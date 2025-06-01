svm_linear <- function(df) {
  start_time <- Sys.time()
  
  train_index <- sample(1:nrow(df), 0.7 * nrow(df)) 
  train_data <- df[train_index, ]
  test_data <- df[-train_index, ]
  
  svmLinear_model <- svm(t ~ ., 
                         data = train_data, 
                         kernel = "linear", 
                         cost = 1,
                         scale = FALSE,
                         na.action = na.omit
  )
  
  predictions <- predict(svmLinear_model, newdata = test_data)
  cm <- confusionMatrix(predictions, test_data$t)
  
  end_time <- Sys.time()
  cpu_time <- end_time - start_time
  
  return(c(cm$overall["Accuracy"], cpu_time))
}

svm_radial <- function(df) {
  start_time <- Sys.time()
  
  train_index <- sample(1:nrow(df), 0.7 * nrow(df)) 
  train_data <- df[train_index, ]
  test_data <- df[-train_index, ]
  
  svmRad_model <- svm(t ~ ., 
                      data = train_data, 
                      kernel = "radial",
                      cost = 1,
                      scale = FALSE,
                      na.action = na.omit
  )
  
  predictions <- predict(svmRad_model, newdata = test_data)
  cm <- confusionMatrix(predictions, test_data$t)
  
  end_time <- Sys.time()
  cpu_time <- end_time - start_time
  
  return(c(cm$overall["Accuracy"], cpu_time))
}


bnb <- function(df) {
  start_time <- Sys.time()
  
  train_index <- sample(1:nrow(df), 0.7 * nrow(df))  # 70% for training
  train_data <- df[train_index, ]
  test_data <- df[-train_index, ]
  
  X_train <- train_data[, -ncol(df)]
  y_train <- train_data[, ncol(df)]
  X_test <- test_data[, -ncol(df)]
  y_test <- test_data[, ncol(df)]
  
  X_train_num <- as.matrix(as.data.frame(lapply(X_train, function(x) as.numeric(as.character(x)))))
  y_train_num <- as.matrix(as.data.frame(lapply(y_train, function(x) as.numeric(as.character(x)))))
  X_test_num <- as.matrix(as.data.frame(lapply(X_test, function(x) as.numeric(as.character(x)))))
  y_test_num <- as.matrix(as.data.frame(lapply(y_test, function(x) as.numeric(as.character(x)))))
  
  model <- bernoulli_naive_bayes(x = X_train_num, y = y_train, laplace = 0)
  
  predictions <- predict(model, newdata = X_test_num, type = 'class')
  cm <- confusionMatrix(predictions, y_test)
  
  end_time <- Sys.time()
  cpu_time <- end_time - start_time
  return(c(cm$overall["Accuracy"], cpu_time))
}

knn_hamming <- function(df, k = 1) {
  start_time <- Sys.time()
  
  target_col <- ncol(df)
  features <- df[, -target_col]
  target <- df[, target_col]
  
  set.seed(123)
  train_index <- createDataPartition(target, p = 0.7, list = FALSE)
  train_data <- features[train_index, ]
  test_data <- features[-train_index, ]
  train_labels <- target[train_index]
  test_labels <- target[-train_index]

  train_numeric <- as.matrix(sapply(train_data, function(x) as.numeric(as.character(x))))
  test_numeric <- as.matrix(sapply(test_data, function(x) as.numeric(as.character(x))))

  hamming_dist <- function(test_row, train_mat) {
    test_mat <- matrix(test_row, nrow = nrow(train_mat), ncol = length(test_row), byrow = TRUE)
    rowSums(test_mat != train_mat)
  }

  predict_knn <- function(test_data, train_data, train_labels, k) {
    predictions <- sapply(1:nrow(test_data), function(i) {
      distances <- hamming_dist(test_data[i, ], train_data)
      nearest <- order(distances)[1:k]
      neighbor_labels <- train_labels[nearest]

      label_counts <- table(neighbor_labels)
      predicted_label <- names(label_counts)[which.max(label_counts)]
      
      as.factor(predicted_label)
    })
    factor(predictions, levels = levels(train_labels))
  }

  predictions <- predict_knn(test_numeric, train_numeric, train_labels, k)

  cm <- confusionMatrix(predictions, test_labels)

  end_time <- Sys.time()
  cpu_time <- end_time - start_time
  
  return(c(cm$overall["Accuracy"], cpu_time))
}


svm_jaccard <- function(df) {
  start_time <- Sys.time()
  
  train_index <- sample(1:nrow(df), 0.7 * nrow(df)) 
  train_data <- df[train_index, ]
  test_data <- df[-train_index, ]
  
  X_train <- train_data[, -ncol(df)]
  y_train <- train_data[, ncol(df)]
  X_test <- test_data[, -ncol(df)]
  y_test <- test_data[, ncol(df)]
  
  X_train_num <- as.data.frame(lapply(X_train, function(x) as.numeric(as.character(x))))
  X_test_num <- as.data.frame(lapply(X_test, function(x) as.numeric(as.character(x))))
  
  myk <- function(x, y) {
    inter <- sum(x & y)
    union <- sum(x | y)
    if (union == 0) return(0)
    return(inter / union)
  }
  
  class(myk) <- "kernel"
  
  svmJaccard_model <- ksvm(t~., 
                           data=train_data,
                           kernel = myk)
  
  predictors <- predict(svmJaccard_model, test_data)
  
  table(predictors, y_test)
  
  cm <- confusionMatrix(predictors, y_test)
  
  end_time <- Sys.time()
  cpu_time <- end_time - start_time
  return(c(cm$overall["Accuracy"], cpu_time))
}


logistic_regression <- function(df) {
  start_time <- Sys.time()
  
  target_col <- names(df)[ncol(df)]
  
  set.seed(123)
  train_indices <- sample(seq_len(nrow(df)), size = 0.7 * nrow(df))
  train_data <- df[train_indices, ]
  test_data  <- df[-train_indices, ]
  
  model <- glm(as.formula(paste(target_col, "~ .")), data = train_data, family = binomial())
  
  probs <- predict(model, newdata = test_data, type = "response")
  preds <- ifelse(probs > 0.5, 1, 0)
  preds <- factor(preds, levels = levels(df[[target_col]]))
  
  acc <- mean(preds == test_data[[target_col]])
  
  end_time <- Sys.time()
  elapsed <- as.numeric(difftime(end_time, start_time, units = "secs"))
  
  return(c(acc, elapsed))
}


make_experiments <- function(sizes) {
  data_correlations <- c("1dependent", "dcp", "exchangeable")
  data_complexities <- c("easy", "medium", "hard")
  
  script_path <- rstudioapi::getSourceEditorContext()$path
  script_dir <- dirname(script_path)
  
  stored_dir <- file.path(script_dir, "stored_datasets")
  results_dir <- file.path(script_dir, "results")
  figures_boxplot_dir <- file.path(script_dir, "figures", "accuracies_boxplots")
  figures_cpu_dir <- file.path(script_dir, "figures", "accuracies_cpu")
  
  dir.create(results_dir, recursive = TRUE, showWarnings = FALSE)
  dir.create(figures_boxplot_dir, recursive = TRUE, showWarnings = FALSE)
  dir.create(figures_cpu_dir, recursive = TRUE, showWarnings = FALSE)
  
  for (i in seq_along(sizes)) {
    for (j in seq_along(data_correlations)) {
      for (k in seq_along(data_complexities)) {
        
        data_folder <- file.path(
          stored_dir,
          sizes[i],
          paste0(data_correlations[j], "_", data_complexities[k])
        )
        
        if (!dir.exists(data_folder)) {
          warning("Carpeta no encontrada: ", data_folder)
          next
        }
        
        pattern <- "^D[0-9]+_.*_mu[0-9]+(\\.[0-9]+)?_sd[0-9]+(\\.[0-9]+)?\\.csv$"
        files <- list.files(data_folder, pattern = pattern, full.names = TRUE)
        
        cat("Entering:", sizes[i], data_correlations[j], data_complexities[k], "\n")
        
        evaluate_dataset <- function(file) {
          df <- tryCatch(read.csv(file), error = function(e) return(NULL))
          if (is.null(df)) return(NULL)
          
          df[] <- lapply(df, as.factor)
          
          non_target_cols <- df[, -ncol(df), drop = FALSE]
          multi_level_cols <- sapply(non_target_cols, function(col) nlevels(col) > 1)
          df_clean <- cbind(non_target_cols[, multi_level_cols, drop = FALSE], t = df[[ncol(df)]])
          
          if (nlevels(df_clean$t) < 2) {
            warning("Only one value in label column", basename(file))
            return(NULL)
          }
          
          results_bnb     <- tryCatch(bnb(df_clean), error = function(e) c(NA, NA))
          results_knn     <- tryCatch(knn_hamming(df_clean), error = function(e) c(NA, NA))
          results_jaccard <- tryCatch(svm_jaccard(df_clean), error = function(e) c(NA, NA))
          results_linear  <- tryCatch(svm_linear(df_clean), error = function(e) c(NA, NA))
          results_rb      <- tryCatch(svm_radial(df_clean), error = function(e) c(NA, NA))
          results_lr      <- tryCatch(logistic_regression(df_clean), error = function(e) c(NA, NA))
          
          data.frame(
            dataset          = basename(file),
            size             = sizes[i],
            correlation      = data_correlations[j],
            complexity       = data_complexities[k],
            accuracy_bnb     = results_bnb[1],
            cpu_bnb          = results_bnb[2],
            accuracy_knn     = results_knn[1],
            cpu_knn          = results_knn[2],
            accuracy_jaccard = results_jaccard[1],
            cpu_jaccard      = results_jaccard[2],
            accuracy_linear  = results_linear[1],
            cpu_linear       = results_linear[2],
            accuracy_rb      = results_rb[1],
            cpu_rb           = results_rb[2],
            accuracy_lr      = results_lr[1],
            cpu_lr           = results_lr[2],
            stringsAsFactors = FALSE
          )
        }
        
        if (length(files) == 0) next
        
        num_cores <- min(10, detectCores() - 1)
        results_list <- mclapply(files, evaluate_dataset, mc.cores = num_cores)
        experiment_results <- do.call(rbind, results_list)
        
        if (is.null(experiment_results) || nrow(experiment_results) == 0) {
          warning("No results for ", sizes[i], "_", data_correlations[j], "_", data_complexities[k])
          next
        }
        
        # CSV file in results/
        output_file <- paste0("results_", sizes[i], "_", data_correlations[j], "_", data_complexities[k], ".csv")
        write.csv(experiment_results, file.path(results_dir, output_file), row.names = FALSE)
        message("Saved: ", output_file)
        
        # Accuracy boxplot → figures/accuracies_boxplots/
        png(file.path(figures_boxplot_dir, paste0("boxplot_accuracy_", sizes[i], "_", data_correlations[j], "_", data_complexities[k], ".png")),
            width = 950, height = 600)
        
        boxplot(
          experiment_results[, c("accuracy_bnb", "accuracy_knn", "accuracy_jaccard", "accuracy_linear", "accuracy_rb", "accuracy_lr")],
          names = c("Bernoulli NB", "k-NN", "SVM-Jaccard", "SVM-Linear", "SVM-Radial", "Logistic Regression"),
          main = "Classifier Accuracy Comparison", ylab = "Accuracy",
          col = "gray", border = "black"
        )
        abline(v = 3.5, lty = 2, col = "grey", lwd = 2)
        dev.off()
        
        # CPU time boxplot → figures/accuracies_cpu/
        png(file.path(figures_cpu_dir, paste0("boxplot_cputime_", sizes[i], "_", data_correlations[j], "_", data_complexities[k], ".png")),
            width = 950, height = 600)
        
        boxplot(
          experiment_results[, c("cpu_bnb", "cpu_knn", "cpu_jaccard", "cpu_linear", "cpu_rb", "cpu_lr")],
          names = c("Bernoulli NB", "k-NN", "SVM-Jaccard", "SVM-Linear", "SVM-Radial", "Logistic Regression"),
          main = "Classifier Computation Time", ylab = "CPU Time (s)",
          col = "gray", border = "black"
        )
        abline(v = 3.5, lty = 2, col = "grey", lwd = 2)
        dev.off()
      }
    }
  }
}
