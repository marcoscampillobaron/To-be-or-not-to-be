library(rstudioapi)
library(CorBin)
library(ECoL)
library(simcausal)
library(truncnorm)
library(parallel)
library(e1071)
library(caret)
library(dplyr)
library(class)
library(kknn)
library(ggplot2)
library(reshape2)
library(naivebayes)
library(kernlab)
library(kerntools)
library(reticulate)
reticulate::use_virtualenv("~/tfg_env", required = TRUE)



this_file <- rstudioapi::getSourceEditorContext()$path
this_dir <- dirname(this_file)
source(file.path(this_dir, "To-be-or-not-to-be-complementary-functions.R"))
source(file.path(this_dir, "To-be-or-not-to-be-generation-functions.R"))
source(file.path(this_dir, "To-be-or-not-to-be-complexity-mapping.R"))
source(file.path(this_dir, "To-be-or-not-to-be-experiments.R"))

executable <- function() {
  create_datasets_directory()
  # sizes <- c("N2M1", "N2M2", "N2M3", "N3M1", "N3M2", "N3M3", "N4M1", "N4M2", "N4M3")
  sizes <- c("N2M1") # Eliminate this line and uncomment the previous one under your responsability.
  create_size_subfolders(sizes)
  generate_datasets(sizes)
  make_experiments(sizes)
}

executable()


