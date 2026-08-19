# Historical Stock Analysis

Coursework is organized by assignment. Run analysis and build commands from the repository root so the shared `data/stock_data.csv` path resolves consistently.

## Repository layout

```text
assignment_1/
  docs/
    assignments/       # question files
    submissions/       # final submission files
  figures/
assignment_2/
  analysis.ipynb
  build_submission.py
  docs/assignments/
  docs/submissions/
  figures/
assignment_3/
  analysis.ipynb
  docs/assignments/
  docs/references/
  docs/submissions/
  figures/
assignment_4/
  analysis.R
  build_submission.py
  docs/assignments/
  docs/submissions/
  figures/
assignment_5/
  part_1/
    docs/assignments/
    docs/submissions/
    figures/
  part_2/
    analysis.R
    build_submission.py
    docs/assignments/
    docs/submissions/
    figures/
    tables/
extra_credit_1/
  analysis.ipynb
  build_submission.py
  chart_style.py
  docs/assignments/
  docs/submissions/
  figures/
data/                     # shared source dataset
```

`docs/assignments` contains the instructor's question or brief. `docs/submissions` contains the team's deliverable files. Code, generated figures, tables, and supporting references stay beside the assignment that owns them.

Assignment 1 currently has no source files. The question files for Assignments 2 and 3 and Extra Credit 1 are also not present in the repository, so their assignment folders are placeholders. Assignment 5 is divided into Part 1 and Part 2.

## Rebuild commands

Run these from the repository root.

```bash
# Assignment 2
uv run python assignment_2/build_submission.py

# Assignment 4
Rscript assignment_4/analysis.R
uv run python assignment_4/build_submission.py

# Assignment 5, Part 2
Rscript assignment_5/part_2/analysis.R
uv run python assignment_5/part_2/build_submission.py

# Extra Credit 1
uv run python extra_credit_1/build_submission.py
```

Assignment 3's executed analysis is `assignment_3/analysis.ipynb`; its figures and submitted report are stored in the same assignment folder.
