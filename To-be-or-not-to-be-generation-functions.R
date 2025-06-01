generate_exchangeable_dataset <- function(N, M, p) {
  rho_max <- rhoMaxEx(p)
  rho <- runif(n=1, min=0, max=rho_max)
  df <- as.data.frame(cBernEx(n=N, p=p, rho=rho))
  df[] <- lapply(df, as.factor)
  colnames(df) <- gsub(" ", "", paste("ft", 1:M))
  return(df)
}

generate_dcp_dataset <- function(N, M, p) {
  rho_max <- rhoMaxDCP(p)
  rho <- runif(n=M-1, min=0, max=rho_max)
  df <- as.data.frame(cBernDCP(n=N, p=p, rho=rho))
  df[] <- lapply(df, as.factor)
  colnames(df) <- gsub(" ", "", paste("ft", 1:M))
  return(df)
}

generate_1dependent_dataset <- function(N, M, p) {
  if (M > 2) {
    rho_max <- rhoMax1dep(p)
    rho <- runif(M-1, 0, min(1,rho_max))
  }
  else rho <- 0.1
  df <- as.data.frame(cBern1dep(n=N, p=p, rho=rho))
  df[] <- lapply(df, as.factor)
  colnames(df) <- gsub(" ", "", paste("ft", 1:M))
  return(df)
}

evaluate_complexity <- function(df) {
  
  data <- df[, -ncol(df)]
  data_numeric <- data.frame(lapply(data, function(x) as.numeric(as.character(x))))
  
  labels <- df[, ncol(df)]
  labels_numeric <- as.numeric(as.character(labels))
  
  L2 <- linearity(x = data_numeric, y = labels_numeric, measures = "L2")[1]$L2[1]
  C2 <- balance(x = data_numeric, y = labels_numeric, measures = "C2")[1]$C2[1]
  
  names(L2) <- NULL
  names(C2) <- NULL
  return(c(L2, C2))
}

evaluate_L2_complexity <- function(df) {
  
  data <- df[, -ncol(df)]
  data_numeric <- data.frame(lapply(data, function(x) as.numeric(as.character(x))))
  
  labels <- df[, ncol(df)]
  labels_numeric <- as.numeric(as.character(labels))
  
  L2 <- linearity(x = data_numeric, y = labels_numeric, measures = "L2")[1]$L2[1]
  
  names(L2) <- NULL
  return(L2)
}

size_to_text <- function(code) {
  a <- as.numeric(sub("N(\\d)M(\\d)", "\\1", code))
  b <- as.numeric(sub("N(\\d)M(\\d)", "\\2", code))
  N <- 10^a
  M <- 10^b
  paste0("N = ", N, ", M = ", M)
}

size_to_numbers <- function(code) {
  a <- as.numeric(sub("N(\\d)M(\\d)", "\\1", code))
  b <- as.numeric(sub("N(\\d)M(\\d)", "\\2", code))
  N <- 10^a
  M <- 10^b
  return(c(N,M))
}

generate_datasets <- function(sizes) {
  complexity_mapping <- get_complexity_mapping()
  
  generate_dataset_random_labels <- function(N, M, p = NULL, correlation, prob) {
    
    if (correlation == "exchangeable") {
      if (is.null(p)) {
        cat("You need to specify p")
        return()
      }
      df <- generate_exchangeable_dataset(N=N, M=M, p=p)
    }
    else if (correlation == "dcp") {
      if (is.null(p)) {
        cat("You need to specify p")
        return()
      }
      df <- generate_dcp_dataset(N=N, M=M, p=p)
    }
    else if (correlation == "1dependent") {
      if (is.null(p)) {
        cat("You need to specify p")
        return()
      }
      df <- generate_1dependent_dataset(N=N, M=M, p=p)
    }
    else {
      cat("No valid correlation argument")
      return()
    }
    df$t <- as.factor(rbern(N, prob = prob))
    return(df)
  }
  
  script_path <- rstudioapi::getSourceEditorContext()$path
  script_dir <- dirname(script_path)
  
  stored_dir <- file.path(script_dir, "stored_datasets")
  figures_dir <- file.path(script_dir, "figures", "L2_measures")
  
  if (!dir.exists(figures_dir)) {
    dir.create(figures_dir, recursive = TRUE)
  }
  
  data_correlations <- c("1dependent", "dcp", "exchangeable")
  mu_means <- c(0.5, 0.6, 0.7, 0.8, 0.9)
  sigma_sd <- c(0.1, 0.25, 0.5, 0.75, 1)
  for (i in 1:length(sizes)) {
    N <- size_to_numbers(sizes[i])[1]
    M <- size_to_numbers(sizes[i])[2]
    for (j in 1:length(data_correlations)) {
      for (k in 1:length(mu_means)) {
        for (l in 1:length(sigma_sd)) {
          p_total <- runif(M, 0.1, 0.9)
          aux <- rtruncnorm(M, a = rep(0,M), b = rep(1,M), mean = mu_means[k], sd = sigma_sd[l])
          p <- p_total * aux
          q <- p_total - p
          L2_list <- c()
          info_list <- list()
          for (m in 1:20) {
            set.seed(as.integer(Sys.time()) + m + i*1000 + j*100 + k*10 + l)
            if (data_correlations[j] == "exchangeable") {
              df0 <- generate_dataset_random_labels(N=N/2, M=M, p=q, correlation = "exchangeable", prob = 0)
              df1 <- generate_dataset_random_labels(N=N/2, M=M, p=p, correlation = "exchangeable", prob = 1)
              df <- rbind(df0, df1)
              df <- df[sample(nrow(df)),]
            }
            else if (data_correlations[j] == "1dependent") {
              df0 <- generate_dataset_random_labels(N=N/2, M=M, p=q, correlation = "1dependent", prob = 0)
              df1 <- generate_dataset_random_labels(N=N/2, M=M, p=p, correlation = "1dependent", prob = 1)
              df <- rbind(df0, df1)
              df <- df[sample(nrow(df)),]
            }
            else if (data_correlations[j] == "dcp") {
              df0 <- generate_dataset_random_labels(N=N/2, M=M, p=q, correlation = "dcp", prob = 0)
              df1 <- generate_dataset_random_labels(N=N/2, M=M, p=p, correlation = "dcp", prob = 1)
              df <- rbind(df0, df1)
              df <- df[sample(nrow(df)),]
            }
            param_folder <- paste0("mu_", mu_means[k], "_sigma_", sigma_sd[l])
            output_folder <- file.path(stored_dir, sizes[i], data_correlations[j], param_folder)
            if (!dir.exists(output_folder)) {
              dir.create(output_folder, recursive = TRUE)
            }
            if (!dir.exists(output_folder)) {
              dir.create(output_folder, recursive = TRUE)
            }
            dataset_name <- paste0("D", m, "_", data_correlations[j], "_mu", mu_means[k], "_sd", sigma_sd[l], ".csv")
            dataset_path <- file.path(output_folder, dataset_name)
            write.csv(df, dataset_path, row.names = FALSE)
            
            L2 <- evaluate_complexity(df)[1]
            L2_list <- c(L2_list, L2)
            list_name <- paste0("L2_list_", sizes[i], "_", data_correlations[j], "_mu", mu_means[k], "_sigma", sigma_sd[l])
            assign(list_name, L2_list)
            
            info_list[[m]] <- data.frame(
              Name = dataset_name,
              N = N,
              M = M,
              Correlation = data_correlations[j],
              Mu = mu_means[k],
              Sigma = sigma_sd[l],
              L2 = L2
            )
          }
          datasets_info <- do.call(rbind, info_list)
          info_file_path <- file.path(output_folder, "datasets_info.csv")
          write.csv(datasets_info, info_file_path, row.names = FALSE)
          row_match <- subset(complexity_mapping,
                              size == sizes[i] &
                                correlation == data_correlations[j] &
                                mu == mu_means[k] &
                                sigma == sigma_sd[l])
          
          if (nrow(row_match) == 1) {
            complexity <- row_match$complexity[1]
            target_folder <- file.path(
              stored_dir,
              sizes[i],
              paste0(data_correlations[j], "_", complexity)
            )

            if (!dir.exists(target_folder)) {
              dir.create(target_folder, recursive = TRUE)
            }
            
            for (m in 1:20) {
              dataset_name <- paste0("D", m, "_", data_correlations[j], "_mu", mu_means[k], "_sd", sigma_sd[l], ".csv")
              src_path <- file.path(output_folder, dataset_name)
              dst_path <- file.path(target_folder, dataset_name)
              file.copy(src_path, dst_path, overwrite = TRUE)
            }
            
            file.copy(file.path(output_folder, "datasets_info.csv"),
                      file.path(target_folder, "datasets_info.csv"),
                      overwrite = TRUE)
          }
          
        }
      }
      
      png_path <- file.path(figures_dir, paste0("L2grid_", sizes[i], "_", data_correlations[j], ".png"))
      png(png_path, width = 2400, height = 2400, res = 300)
      
      attach(mtcars)
      par(mfrow = c(5, 5), oma = c(0, 2, 7, 1), mar = c(2, 2, 1, 1))
      
      for (k in 1:length(mu_means)) {
        for (l in 1:length(sigma_sd)) {
          list_name <- paste0("L2_list_", sizes[i], "_", data_correlations[j], "_mu", mu_means[k], "_sigma", sigma_sd[l])
          L2_list <- get(list_name)
          boxplot(L2_list,
                  ylim = c(0, 0.4),
                  col = "grey", 
                  border = "black",
                  boxwex = 1.5)
          coords <- par("usr")  
          mean_val <- mean(L2_list, na.rm = TRUE)
          text(x = 1, y = coords[4] - 0.1, labels = paste0("mean = ", round(mean_val, 3)), cex = 1.4, col = "orange")
        }
      }
      mtext(size_to_text(sizes[i]), side = 3, line = 3, outer = TRUE, cex = 2.5, font = 2)
      
      for (k in 1:length(sigma_sd)) {
        y_pos <- 1 - (k - 0.5) / length(sigma_sd)
        mtext(paste0("sigma = ", sigma_sd[k]), side = 2, line = 0.5, at = y_pos, outer = TRUE, cex = 1.2)
      }
      
      for (l in 1:length(mu_means)) {
        x_pos <- (l - 0.5) / length(mu_means)
        mtext(paste0("mu = ", mu_means[l]), side = 3, line = 1, at = x_pos, outer = TRUE, cex = 1.2)
      }
      
      dev.off()
    }
  }
}
