# Historical Stock Analysis

## Purpose

This repository contains Team 2 coursework for a data-visualization course. The deliverables are charts, written interpretations, and presentations. This is not a trading system, portfolio optimizer, or forecasting project.

Work from the repository root so shared paths such as `data/stock_data.csv` resolve consistently.

## Team and project identity

- Team: 2
- Registration number used for filenames: 26120004
- Project title: Historical Stock Analysis
- Team members:
  - Karthikeyan M (26120004)
  - Mirthula M (26120121)
  - Lakshmi Mayuri Kavya N (26120161)
- Original dataset source: https://www.kaggle.com/datasets/ibrahimshahrukh/top-50-companies-dataset
- The Kaggle source page has since been removed by its uploader. Keep that caveat when citing it.

## Environment

- Python version: 3.14, managed with `uv` from `pyproject.toml` and `uv.lock`.
- Do not use the system Python for project work.
- Python stack: pandas, matplotlib, seaborn, Plotly, Altair, SciPy, Jupyter, python-docx.
- R stack used by the project: tidyverse, data.table, lubridate, reshape2, lattice.
- In a restricted Codex sandbox, set a writable uv cache, for example:

```bash
UV_CACHE_DIR=/private/tmp/historical-stock-analysis-uv-cache uv run python ...
```

## Repository layout

- `data/stock_data.csv`: shared, read-only source dataset.
- `assignment_2/`: executed Python EDA notebook and DOCX builder.
- `assignment_3/`: hypotheses, related work, proposed analysis, figures, and report.
- `assignment_4/`: R version of the EDA and DOCX builder.
- `assignment_5/part_1/`: instructor brief only; no team submission is currently present.
- `assignment_5/part_2/`: completed R wrangling analysis, figures, tables, DOCX, and PDF.
- `extra_credit_1/`: advanced visualization exercises, including the strongest before/after redesign and widened-region analysis.
- `half-way-presentation/`: current Assignment 6 project-status-presentation brief and its PDF conversion.

Within an assignment, keep instructor material under `docs/assignments` or the existing singular `docs/assignment` folder, and team deliverables under `docs/submissions`. Keep code, figures, tables, and references beside the assignment that owns them.

## Dataset facts verified on 2026-08-25

- Shape: 230,111 rows x 8 columns.
- Grain: one ticker per trading day.
- Date range: 2006-01-02 through 2026-02-20.
- Tickers: 49.
- Missing fields: 0.
- Duplicate `(Date, Ticker)` pairs: 0.
- Zero-volume rows: 1,706.
- Columns: Date, Ticker, Open, High, Low, Close, Adj Close, Volume.

### Data pitfalls

1. Prices mix currencies. Never compare raw price levels across tickers on one axis. Use returns or index every series to 100 on a valid common start date.
2. Tickers start on different dates. Choose the rebase date only after confirming every plotted ticker exists.
3. Trading calendars differ across exchanges. Cross-market joins can create gaps; resample or fill deliberately and disclose the method.
4. In this dataset, `Close` is already adjusted for historical splits. `Adj Close` additionally accounts for dividends. Use `Adj Close` for returns and growth.
5. Market labels are unbalanced. The United States dominates the rows; Paris and Saudi Arabia each represent one company, so do not overgeneralize market-level findings.
6. `Volume` is share count and is affected by splits. It is not directly comparable across companies as dollar trading activity.
7. The data stops on 2026-02-20. Do not call the last observation current or today.

## Central analysis thread

The project argues that apparent diversification is thinner than it looks, both within large-cap technology and across world regions during crisis periods.

### H1: AI-rally concentration

- Chip/AI group: NVDA, AVGO, TSM, ASML, AMD, MU, LRCX.
- Comparison group: AAPL, MSFT, GOOGL, AMZN, META, NFLX, ORCL, CSCO.
- From 2023-01-03 through 2026-02-20, the chip/AI group gained about 549% on average versus about 168% for the rest-of-tech group.
- Extra Credit 1 found mean daily returns of 0.26% versus 0.14%; Welch's t-test p = 0.0073.
- State the conclusion narrowly: the selected chip/AI group outperformed the selected broader-tech group. Do not claim this proves the entire AI economy is narrow.

### H2: regional diversification during crises

- The first analysis used one stock per region and found average correlations of about 0.25 in calm 2015-2017, 0.25 in 2008, 0.53 in 2020, and 0.21 in 2022.
- Extra Credit 1 widened the available regional baskets. Correlations became about 0.282 in calm years, 0.326 in 2008, 0.539 in 2020, and 0.196 in 2022.
- The wider basket makes 2008 more distinct, but Paris still has one stock and Korea/Switzerland remain sector-narrow. Present this as qualified evidence, not a universal market law.

### H3: volatility and volume during panic periods

- One-stock-per-region analysis found volatility of about 0.015 in calm years, 0.046 in 2008, 0.036 in 2020, and 0.020 in 2022.
- Volume relative to calm was about 1.0x, 2.7x, 1.7x, and 0.9x, respectively.
- Assignment 5 Part 2 independently found the highest equal-weighted monthly absolute returns in October 2008 (4.82%) and March 2020 (4.67%).
- The defensible claim is that panic periods in this dataset show strong volatility/volume spikes; the correlation evidence is strongest for 2020 and more qualified for 2008.

## Current priority: Assignment 6 halfway presentation

- Presentation: Thursday, 2026-08-27, in class.
- Deck deadline: Wednesday, 2026-08-26 at 11:59 PM via DigiiCampus.
- Required filename stem: `26120004_2_Presentation`.
- Accepted deck format: PDF or PPTX.
- Total slot: 10 minutes, with a hard cutoff; reserve about 1 minute for Q&A.
- Target: 8-10 slides.
- Every team member must speak for a meaningful portion.
- Required story: title/team, question and related work, data and Python/R approach, 2-3 key findings, one before/after redesign, and next steps for Power BI/Tableau.
- Every chart needs a written takeaway. Use one idea per slide and keep slides readable from the back of the room.
- The best existing redesign is `extra_credit_1/figures/ec1_a_before.png` versus `extra_credit_1/figures/ec1_a_after.png`. It changes the indexed-growth chart from a linear to log y-axis and separates overlapping end labels.
- Good finding visuals are:
  - `assignment_3/figures/figure_a_ai_rally.png`
  - `extra_credit_1/figures/ec1_f_widened_basket.png`
  - `assignment_5/part_2/figures/b2_monthly_absolute_return.png`
  - `assignment_3/figures/figure_b_crisis_correlation.png`, if its one-stock-per-region limitation is stated.
- The missing Assignment 5 Part 1 submission must not be invented. The Assignment 6 brief explicitly allows a strong Extra Credit 1 example to be folded into Design Evolution, so use the EC1 before/after chart.

## Rebuild commands

Run from the repository root.

```bash
UV_CACHE_DIR=/private/tmp/historical-stock-analysis-uv-cache uv run python assignment_2/build_submission.py

Rscript assignment_4/analysis.R
UV_CACHE_DIR=/private/tmp/historical-stock-analysis-uv-cache uv run python assignment_4/build_submission.py

Rscript assignment_5/part_2/analysis.R
UV_CACHE_DIR=/private/tmp/historical-stock-analysis-uv-cache uv run python assignment_5/part_2/build_submission.py

UV_CACHE_DIR=/private/tmp/historical-stock-analysis-uv-cache uv run python extra_credit_1/build_submission.py
```

Assignment 3 is driven by the executed `assignment_3/analysis.ipynb`; there is no separate builder.

## Working conventions

- Treat `data/stock_data.csv` as read-only. Put reproducible derived tables in the assignment's `tables/` folder.
- Keep notebooks executable and scripts reproducible. Do not hand-edit generated tables or figures.
- Every chart needs axis labels with units, a source note, and the date range or transformation used.
- Prefer colorblind-safe palettes and direct line labels. Reuse the project colors consistently when the same groups recur.
- For cross-ticker charts, state the normalization in the title or caption.
- Build explanations step by step for a team without a finance background.
- In notebook markdown, use lowercase bold headings instead of `##` headers. Use bullet-point interpretations with blank lines between bullets.
- Write column names and paths as plain text in student-facing prose; avoid an overly technical or AI-generated tone.
- Avoid em dashes in code comments.
- Never silently fill team-owned placeholders or fabricate sources, dates, financial explanations, or results.
- When exporting DOCX, PDF, or PPTX deliverables, render and inspect every page or slide before delivery.

## Known repo state and caveats

- Assignment 2, Assignment 3, Assignment 4, Extra Credit 1, and Assignment 5 Part 2 contain substantial completed work.
- Assignment 3's stored DOCX still contains old placeholders for team members and the dataset source even though later assignments resolved them. Do not copy those placeholders into new work.
- Assignment 5 Part 1 has only the instructor brief and placeholder directories; no completed submission file is present.
- The tracked `.DS_Store` files and `.Rhistory` are legacy repository clutter. Do not treat them as project inputs.
- Preserve unrelated user changes in the worktree. As of the 2026-08-25 audit, `assignment_5/part_2/docs/.DS_Store` had an existing modification.
