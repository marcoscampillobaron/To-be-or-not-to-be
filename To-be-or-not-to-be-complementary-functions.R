create_datasets_directory <- function() {
  
  get_script_path <- function() {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- "--file="
    script_path <- sub(file_arg, "", args[grep(file_arg, args)])
    if (length(script_path) == 0) {
      if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
        return(normalizePath(rstudioapi::getSourceEditorContext()$path))
      } else {
        stop("Could not determine the script path. Make sure you are running this in RStudio or using Rscript.")
      }
    }
    return(normalizePath(script_path))
  }
  
  script_path <- get_script_path()
  script_dir <- dirname(script_path)
  stored_dir <- file.path(script_dir, "stored_datasets")
  
  if (!dir.exists(stored_dir)) {
    dir.create(stored_dir)
    message("Created 'stored_datasets' folder at: ", stored_dir)
  } else {
    message("Folder 'stored_datasets' already exists at: ", stored_dir)
  }
}


create_size_subfolders <- function(sizes) {
  
  get_script_path <- function() {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- "--file="
    script_path <- sub(file_arg, "", args[grep(file_arg, args)])
    if (length(script_path) == 0) {
      if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
        return(normalizePath(rstudioapi::getSourceEditorContext()$path))
      } else {
        stop("Could not determine the script path. Make sure you are running this in RStudio or using Rscript.")
      }
    }
    return(normalizePath(script_path))
  }
  
  script_path <- get_script_path()
  script_dir <- dirname(script_path)
  stored_dir <- file.path(script_dir, "stored_datasets")
  
  for (size in sizes) {
    size_path <- file.path(stored_dir, size)
    if (!dir.exists(size_path)) {
      dir.create(size_path)
      message(paste0("Created folder for size '", size, "' at: ", size_path))
    } else {
      message(paste0("Folder for size '", size, "' already exists at: ", size_path))
    }
  }
}




















