"""Shared chart style for the historical stock analysis project.

Colorblind safe categorical palette (Okabe-Ito), a fixed color per group we
reuse across figures, standard font sizes, and a standard figure size. Import
this before building any matplotlib chart so figures look like one system
instead of each notebook picking its own colors.

Usage:
    import sys
    sys.path.insert(0, "scripts")
    import chart_style

    fig, ax = plt.subplots(figsize=chart_style.FIGSIZE_STANDARD)
    ...
    chart_style.apply_style(ax)
"""

import matplotlib.pyplot as plt

# fixed hue order, never cycled or reassigned per chart
PALETTE = ["#0072B2", "#E69F00", "#009E73", "#D55E00", "#56B4E9", "#CC79A7"]

# the two groups from h1 keep the same colors everywhere they appear
GROUP_COLORS = {
    "chip / AI": "#0072B2",
    "rest of tech": "#E69F00",
}

FONT_SIZE_TITLE = 13
FONT_SIZE_LABEL = 11
FONT_SIZE_TICK = 9

FIGSIZE_STANDARD = (8, 5)
FIGSIZE_WIDE = (12, 4.5)


def apply_style(ax):
    """Apply the shared look to a matplotlib axis: no top/right border,
    consistent font sizes, and a light dashed reference line at 0 is left
    to the caller since not every chart needs one."""
    for spine in ["top", "right"]:
        ax.spines[spine].set_visible(False)
    ax.title.set_fontsize(FONT_SIZE_TITLE)
    ax.xaxis.label.set_fontsize(FONT_SIZE_LABEL)
    ax.yaxis.label.set_fontsize(FONT_SIZE_LABEL)
    ax.tick_params(labelsize=FONT_SIZE_TICK)


def set_defaults():
    """Set matplotlib rcParams so figures created without apply_style still
    pick up the same fonts and figure size."""
    plt.rcParams["figure.figsize"] = FIGSIZE_STANDARD
    plt.rcParams["font.size"] = FONT_SIZE_LABEL
    plt.rcParams["axes.titlesize"] = FONT_SIZE_TITLE
    plt.rcParams["xtick.labelsize"] = FONT_SIZE_TICK
    plt.rcParams["ytick.labelsize"] = FONT_SIZE_TICK
