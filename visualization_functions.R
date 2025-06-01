# Package for 2D plots
library(ggplot2)

# Package for 3D plots
library(plotly)

library(dplyr)
library(tidyr)

################################################################################
# HERE THEY GO! SOME 2D VISUALIZATION TOOLS
################################################################################

# Now, I amb going to create a simple 2-D dataset to ckeck visualization

generate_sized_2d_plot <- function(df) {
  # The df expected is a factor df with 3 columns: 2 for features and 1 for target
  ft1 <- colnames(df)[1]
  ft2 <- colnames(df)[2]
  t <- colnames(df)[3]
  
  result <- df %>%
    mutate(feature_pair = factor(paste(ft1, ft2, sep = ","))) %>%
    group_by(t, feature_pair) %>%
    summarise(count = n(), .groups = "drop") %>%
    separate(feature_pair, into = c("ft1", "ft2"), sep = ",") %>%
    mutate(
      ft1 = ifelse(t == 0, as.numeric(ft1) - 0.01, as.numeric(ft1) + 0.01),
      ft2 = ifelse(t == 0, as.numeric(ft2) + 0.01, as.numeric(ft2) - 0.01)
    )
  
  ggplot(result, aes(x = ft1, y = ft2, size = count, color = t)) +
    geom_point(alpha = 0.7) +
    scale_size_continuous(range = c(4, 14)) +  # Adjust size scale for point overlap
    labs(x = "Feature 1", y = "Feature 2", color = "Class", size = "Count") +
    scale_color_manual(values = c("#AEEEEE", "#FFA07A")) +
    geom_hline(yintercept = 0) +
    geom_hline(yintercept = 1) +
    geom_vline(xintercept = 0) +
    geom_vline(xintercept = 1) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank()) +
    ggtitle("Visualization of 2D datapoints as sized vertices")
}


generate_jittered_2d_plot <- function(df) {
  # The df expected is a factor df with 3 columns: 2 for features and 1 for target
  ft1 <- colnames(df)[1]
  ft2 <- colnames(df)[2]
  t <- colnames(df)[3]
  
  ggplot(df, aes(x = ft1, y = ft2, color = t)) +
    geom_jitter(width = 0.1, height = 0.1, size = 4, alpha = 0.7) +
    labs(x = "Feature 1", y = "Feature 2", color = "Class", size = "Count") +
    scale_color_manual(values = c("#AEEEEE", "#FFA07A")) +
    geom_hline(yintercept = 0) +
    geom_hline(yintercept = 1) +
    geom_vline(xintercept = 0) +
    geom_vline(xintercept = 1) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank()) +
    ggtitle("Visualization of 2D datapoints with jitter")
}

################################################################################
# HERE THEY GO! SOME 2D VISUALIZATION TOOLS
################################################################################

generate_sized_3d_plot <- function(df) {
  # The df expected is a factor df with 4 columns: 3 for features and 1 for target
  ft1 <- colnames(df)[1]
  ft2 <- colnames(df)[2]
  ft3 <- colnames(df)[3]
  t <- colnames(df)[4]
  
  result <- df %>%
    mutate(feature_trio = paste(!!sym(ft1), !!sym(ft2), !!sym(ft3), sep = ",")) %>%
    group_by(!!sym(t), feature_trio) %>%
    summarise(count = n(), .groups = "drop") %>%
    separate(feature_trio, into = c("ft1", "ft2", "ft3"), sep = ",", convert = TRUE) %>%
    mutate(
      ft1 = as.numeric(ft1),
      ft2 = as.numeric(ft2),
      ft3 = as.numeric(ft3),
      ft1 = ifelse(t == 0, ft1 - 0.01, ft1 + 0.01),
      ft2 = ifelse(t == 0, ft2 + 0.01, ft2 - 0.01),
      ft3 = ifelse(t == 0, ft3 + 0.01, ft3 - 0.01)
    )
  
  result <- result %>%
    mutate(across(c(ft1, ft2, ft3, count), as.numeric))  
  
  plot_ly() %>%
    add_trace(
      data = result,
      x = ~ft1, y = ~ft2, z = ~ft3,
      size = ~count,
      color = ~t,
      colors = c("#AEEEEE", "#FFA07A"),
      type = "scatter3d",
      mode = "markers",
      marker = list(sizemode = "diameter")
    ) %>%
    layout(
      scene = list(
        xaxis = list(title = "Feature 1", showgrid = FALSE, showbackground = FALSE),
        yaxis = list(title = "Feature 2", showgrid = FALSE, showbackground = FALSE),
        zaxis = list(title = "Feature 3", showgrid = FALSE, showbackground = FALSE)
      ),
      title = "3D Data Visualization with Zero Lines Only"
    )
}

generate_jittered_3d_plot <- function(df) {
  # The df expected is a dataframe with 4 columns: 3 for features and 1 for target
  ft1 <- colnames(df)[1]
  ft2 <- colnames(df)[2]
  ft3 <- colnames(df)[3]
  t <- colnames(df)[4]
  
  # Ensure numeric conversion (avoid factor issues)
  df[[ft1]] <- jitter(as.numeric(as.character(df[[ft1]])), amount = 0.1)
  df[[ft2]] <- jitter(as.numeric(as.character(df[[ft2]])), amount = 0.1)
  df[[ft3]] <- jitter(as.numeric(as.character(df[[ft3]])), amount = 0.1)
  
  # Use column names correctly inside plot_ly
  plot_ly(
    data = df, 
    x = as.formula(paste0("~", ft1)), 
    y = as.formula(paste0("~", ft2)), 
    z = as.formula(paste0("~", ft3)), 
    color = as.formula(paste0("~", t)), 
    colors = c("#AEEEEE", "#FFA07A"), 
    type = "scatter3d", 
    mode = "markers",
    marker = list(size = 5, opacity = 0.7)
  ) %>% 
    layout(
      title = list(
        text = "Easy class separation",
        y = 0.90  # Valor entre 0 (parte inferior) y 1 (parte superior)
      ),
      margin = list(l = 0, r = 0, b = 0, t = 40),  # l: left, r: right, b: bottom, t: top
      scene = list(
        xaxis = list(title = "ft 1", showgrid = FALSE, showbackground = FALSE),
        yaxis = list(title = "ft 2", showgrid = FALSE, showbackground = FALSE),
        zaxis = list(title = "ft 3", showgrid = FALSE, showbackground = FALSE),
        camera = list(
          eye = list(x = 1.2, y = 2.0, z = 0.8)  # adjust for rotation
        )
      ),
      legend = list(x = 0.8, y = 0.8)  # Move legend closer
      
    )
}

# df <- generate_independant_dataset(100,3,c(0.5,0.8,0.3))
# t <- rbinom(100,1,0.5)
# t <- as.factor(df[,1])
# df$t <- t

generate_jittered_3d_plot(df)
