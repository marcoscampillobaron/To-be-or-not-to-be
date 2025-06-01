
# To Be or Not To Be: Learning with Binary Data

This project explores how dataset characteristics (size, correlation, and complexity) influence classification performance. It provides tools for dataset generation, experiment execution, and result visualization.

---

## 📁 Project Structure

- `To-be-or-not-to-be-complementary-functions.R`: Utility functions for directory management.
- `To-be-or-not-to-be-complexity-mapping.R`: Defines mappings of dataset difficulty levels (easy, medium, hard) via mu/sigma parameters.
- `To-be-or-not-to-be-generation-functions.R`: Functions to generate datasets with different correlation structures (1dependent, dcp, exchangeable).
- `To-be-or-not-to-be-experiments.R`: Applies several classifiers and stores results.
- `To-be-or-not-to-be-executable.R`: The main file to launch all experiments.
- `results_presentation_barplots.py`: Python script for generating 3D bar plots of classifier performance.
- `/stored_datasets/`: Contains generated datasets, categorized by size and structure.
- `/results/`: CSV files containing classification results.
- `/figures/`: Generated plots for accuracy, CPU time, and complexity measures.

---

## 🚀 How to Run

### 1. Install R Dependencies

In R, install the required packages:

```r
install.packages(c(
  "e1071", "caret", "dplyr", "class", "kknn", "ggplot2",
  "reshape2", "naivebayes", "kernlab", "kerntools",
  "truncnorm", "parallel"
))
```

And these from GitHub:

```r
remotes::install_github("egregorich/CorBin")
remotes::install_github("fgoncalvesl/eCol")
```

---

### 2. Install Python Packages (for barplots)

Make sure you're using the correct environment and run:

```bash
pip install numpy pandas matplotlib
```

---

### 3. Generate Datasets and Run Experiments

Open `To-be-or-not-to-be-executable.R` in RStudio or an R terminal.

Edit the `sizes` vector to select the dataset configurations you want:

```r
sizes <- c("N2M1", "N3M2", "N4M3")  # Example. You can use any of the available formats.
```

Then execute:

```r
executable()
```

This will:

- Generate all datasets under `/stored_datasets/`
- Run all experiments and classifiers
- Store results under `/results/`
- Save plots under `/figures/`

---

### 4. Plot 3D Barplots (Python)

To visualize classification accuracy:

1. Open `results_presentation_barplots.py`
2. Modify the `sizes` list to match your experiment:

```python
sizes = ['N2M1', 'N3M2', 'N4M3']
```

3. Then run:

```bash
python results_presentation_barplots.py
```

The script will read the CSV files in `/results/` and generate `.png` 3D barplots with classifier accuracy.

---

## 🤖 Classifiers Used

- **Bernoulli Naive Bayes**
- **k-NN (Hamming distance)**
- **SVM - Jaccard kernel**
- **SVM - Linear**
- **SVM - Radial**
- **Logistic Regression**

Each classifier is evaluated on accuracy and CPU time.

---

## 🧠 Dataset Complexity

Complexity levels (`easy`, `medium`, `hard`) are determined by `mu` and `sigma` values for each size/correlation, as defined in the `To-be-or-not-to-be-complexity-mapping.R`.

Only datasets matching those parameters are copied into the final experiment folders.

---

## 👤 Author

**Marcos Campillo Barón**  
Final Degree Project (TFG), 2025  
Universitat Politècnica de Catalunya (UPC)
