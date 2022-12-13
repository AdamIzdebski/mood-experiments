import fsspec
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import numpy as np
from PIL import Image
from typing import Optional, List, Dict
from mood.utils import get_outlier_bounds
from mood.metrics import Metric


def plot_performance_over_distance(
    performance_data: pd.DataFrame,
    calibration_data: pd.DataFrame,
    dataset_name: str,
    ax: Optional = None,
    show_legend: bool = True,
):

    show_legend = True
    if ax is None:
        _, ax = plt.subplots(figsize=(12, 6))

    expected_columns = ["distance", "score_lower", "score_mu", "score_upper"]
    if not all(c in performance_data.columns for c in expected_columns):
        raise ValueError(f"For performance_data, expecting {expected_columns}, found {performance_data.columns}")
    if not all(c in calibration_data.columns for c in expected_columns):
        raise ValueError(f"For calibration_data, expecting {expected_columns}, found {calibration_data.columns}")

    def _plot(data, color, ax):
        sns.lineplot(x=data[:, 0], y=data[:, 2], color=color, ax=ax, lw=4)
        ax.fill_between(data[:, 0], data[:, 1], data[:, 3], color=color, alpha=0.2)
        return ax

    ax = _plot(performance_data[expected_columns].to_numpy(), "tab:blue", ax)
    ax_calibration = _plot(calibration_data[expected_columns].to_numpy(), "tab:orange", ax.twinx())

    perf_metric = Metric.get_default_performance_metric(dataset_name)
    cali_metric = Metric.get_default_calibration_metric(dataset_name)

    if perf_metric.mode == "min":
        ax.invert_yaxis()
    if cali_metric.mode == "min":
        ax_calibration.invert_yaxis()

    label = f"Calibration ({cali_metric.name})"
    ax_calibration.set_ylabel(label, rotation=-90, labelpad=18, fontsize=12)

    label = f"Performance ({perf_metric.name})"
    ax.set_ylabel(label, fontsize=12)
    ax.set_xlabel("Distance")
    ax.set_title(dataset_name, fontsize=18)

    if show_legend:

        legend_lines = [
            plt.Line2D([0], [0], color="tab:blue", lw=4),
            plt.Line2D([0], [0], color="tab:orange", lw=4),
        ]
        labels = ["Performance", "Calibration"]

        ax.legend(
            legend_lines,
            labels,
            fontsize=12,
            loc="lower center",
            ncol=len(labels),
            fancybox=True
        )

    return ax, ax_calibration


def plot_distance_distributions(
    distances, 
    labels: Optional[List[str]] = None, 
    colors: Optional[List[str]] = None, 
    styles: Optional[List[str]] = None,
    ax: Optional = None,
    outlier_factor: Optional[float] = 3.0,
):
    
    n = len(distances)
    show_legend = True
    
    # Set defaults
    if ax is None:
        fig, ax = plt.subplots(figsize=(12, 6))
    if colors is None: 
        cmap = sns.color_palette("rocket", n)
        colors = [cmap[i] for i in range(n)]
    if labels is None: 
        show_legend = False
        labels = [""] * n
    if styles is None: 
        styles = ["-"] * n
    
    ax.spines["right"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["top"].set_visible(False)
    ax.yaxis.set_ticklabels([])
    ax.yaxis.set_ticks([])
    
    if outlier_factor is not None: 
        all_distances = np.concatenate(distances)
        lower, upper = get_outlier_bounds(all_distances, factor=outlier_factor)
        distances = [X[(X >= lower) & (X <= upper)] for X in distances]
        
    # Visualize all splitting methods
    for idx, dist in enumerate(distances): 
        sns.kdeplot(dist, color=colors[idx], linestyle=styles[idx], ax=ax, label=labels[idx])
    
    ax.set_xlabel(f"Distance")
    
    if show_legend:
        ax.legend()
        
    return ax


def visualize_images_in_grid(
    data: Dict[str, Dict[str, str]],
    row_labels: Optional[List[str]] = None,
    col_labels: Optional[List[str]] = None,
    col_size: int = 6, 
    row_size: int = 3,
    tight: bool = True, 
):
    if row_labels is None: 
        row_labels = list(data.keys())
    if col_labels is None:
        col_labels = set()
        for r in row_labels: 
            col_labels.update(data[r].keys())
        col_labels = list(col_labels)
    
    nrows = len(row_labels)
    ncols = len(col_labels)
    
    fig, axs = plt.subplots(ncols=ncols, nrows=nrows, figsize=(col_size * ncols, row_size * nrows))
    axs = np.atleast_2d(axs)
    
    for ri, row in enumerate(row_labels): 
        for ci, col in enumerate(col_labels):
            ax = axs[ri][ci]
            ax.axis("off")
            
            im_path = data[row][col]
            with fsspec.open(im_path) as fd:
                im = Image.open(fd)
                ax.imshow(im, aspect="auto")
    
    if tight:
        plt.tight_layout()
    return fig, axs