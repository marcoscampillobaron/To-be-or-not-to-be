import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import proj3d
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.patches import Patch

plt.rcParams.update({
    "font.size": 16,
    "axes.titlesize": 18,
    "axes.labelsize": 16,
    "xtick.labelsize": 14,
    "ytick.labelsize": 14,
    "legend.fontsize": 14
})

def size_to_NM(size_code):
    n_exp = int(size_code[1])
    m_exp = int(size_code[3])
    N = 10 ** n_exp
    M = 10 ** m_exp
    return N, M

def generate_barplots(sizes):
    base_dir = os.path.dirname(os.path.realpath(__file__))

    results_path = os.path.join(base_dir, "results")
    output_dir = os.path.join(base_dir, "figures", "results_barplots")
    os.makedirs(output_dir, exist_ok=True)

    classifiers = ['bnb', 'knn', 'jaccard', 'linear', 'rb', 'lr']
    difficulties = ['easy', 'medium', 'hard']
    categories = ['1dependent', 'dcp', 'exchangeable']
    colors = ['#D8BFD8', '#FAFAD2', '#B0E0E6']

    for size in sizes:
        size_path = os.path.join(results_path, size)
        folders = [f"{cat}_{diff}" for cat in categories for diff in difficulties]
        results = np.zeros((len(classifiers), len(difficulties), len(categories)))
        highlight_points = []

        for folder in folders:
            for cat_idx, cat in enumerate(categories):
                if folder.startswith(cat):
                    break
            for diff_idx, diff in enumerate(difficulties):
                if folder.endswith(diff):
                    break

            file_path = os.path.join(results_path, f"results_{size}_{folder}.csv")

            try:
                df = pd.read_csv(file_path)
                for clf_idx, clf in enumerate(classifiers):
                    col_name = f"accuracy_{clf}"
                    if col_name in df.columns:
                        results[clf_idx, diff_idx, cat_idx] = df[col_name].mean()
            except Exception as e:
                print(f"Error reading {file_path}: {e}")

        fig = plt.figure(figsize=(9, 9))
        ax = fig.add_subplot(111, projection='3d')
        dx, dy, spacing = 0.15, 0.1, 0.25

        for visual_idx, diff_idx in enumerate([2, 1, 0]):
            draw_order = [0, 1, 2]  
            for offset, cat_idx in enumerate(draw_order[::-1]): 
                color = colors[cat_idx]
                z_raw = results[:, diff_idx, cat_idx]
                z_clipped = np.clip(z_raw, 0.5, 1.0) - 0.5
                zpos_adjusted = np.full_like(z_clipped, 0.5)
                xpos_slice = np.arange(len(classifiers)) + offset * spacing
                ypos_slice = np.full_like(xpos_slice, visual_idx)

                ax.bar3d(
                    xpos_slice, ypos_slice, zpos_adjusted,
                    dx, dy, z_clipped,
                    color=color, edgecolor='black', alpha=0.8
                )

                max_val = np.max(z_raw)
                close_idxs = np.where(np.abs(z_raw - max_val) <= 0.001)[0]
                for i in close_idxs:
                    x = xpos_slice[i] + dx / 2
                    y = ypos_slice[i] + dy / 2
                    z = max(0.5, z_raw[i]) + 0.015
                    color = 'green' if len(close_idxs) > 1 else 'red'
                    highlight_points.append((x, y, z, color))

        for (x, y, z, color) in highlight_points:
            ax.plot([x], [y], [z], marker='o', color=color, markersize=6, zorder=1000)

        ax.set_yticks([0, 1, 2])
        ax.set_yticklabels(['hard', 'medium', 'easy'])
        ax.set_xticks(np.arange(len(classifiers)) + dx)
        ax.set_xticklabels(['bNB', 'kNN', 'SVM-Jaccard', 'SVM-Linear', 'SVM-RBF', 'LogReg'])
        ax.set_zlim(0.5, 1.0)

        N, M = size_to_NM(size)
        ax.set_title(f"Mean Accuracy per Classifier (N = {N}, M = {M})")

        legend_labels = ['exchangeable', 'decaying-product', '1-dependent']
        legend_colors = ['#B0E0E6', '#FAFAD2', '#D8BFD8']
        legend_patches = [Patch(color=c, label=lab) for c, lab in zip(legend_colors, legend_labels)]
        ax.legend(handles=legend_patches, loc='upper left')

        filename = os.path.join(output_dir, f"grafico_resultados_{size}.png")
        plt.savefig(filename, dpi=600, bbox_inches='tight', pad_inches=0.4)
        plt.close(fig)
        print(f"Saved plot: {filename}")



if __name__ == "__main__":
    sizes = ["N2M1"]
    generate_barplots(sizes)
