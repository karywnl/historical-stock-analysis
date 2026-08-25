# Assignment 6: Project Status Presentation Plan

## Non-negotiable requirements

- Submit the deck by Wednesday, 26 August 2026 at 11:59 PM through DigiiCampus.
- Present in class on Thursday, 27 August 2026.
- Filename: `26120004_2_Presentation.pptx` or `26120004_2_Presentation.pdf`.
- Use 8-10 slides.
- The total slot is 10 minutes with a hard cutoff. Rehearse 9 minutes of speaking and leave 1 minute for panel questions.
- Every team member must speak for a meaningful portion.
- Use one main idea per slide.
- Give every chart a direct written takeaway, not only a descriptive title.
- Make every slide readable from the back of the room.

## Recommended 10-slide story

| Slide | Takeaway-style title | Content and existing asset | Time | Speaker |
|---|---|---|---:|---|
| 1 | Historical Stock Analysis: Is diversification thinner than it looks? | Team 2, three members, one-line dataset description | 0:30 | Karthikeyan |
| 2 | Diversification looks broad until we test sectors and crises | State H1-H3 as one connected question: AI-rally concentration, regional correlation in sudden crashes, and volatility/volume during panic | 0:45 | Karthikeyan |
| 3 | Prior work predicts stress correlation, but AI breadth depends on the boundary | One sentence each from Preis et al., Morningstar, and J.P. Morgan; explain how they sharpened the hypotheses | 0:45 | Karthikeyan |
| 4 | We analyzed 230,111 ticker-days twice, in Python and R | 49 tickers, 2006-01-02 to 2026-02-20; Python EDA/hypothesis testing and R replication/wrangling | 0:45 | Mirthula |
| 5 | Mixed currencies and uneven coverage required normalization | Returns/index-to-100, common rebase dates, unequal regional representation, 1,706 zero-volume rows | 0:45 | Mirthula |
| 6 | Selected chip/AI stocks gained 549%; broader tech gained 168% | Use `assignment_3/figures/figure_a_ai_rally.png`; add 0.26% vs 0.14% mean daily return and p = 0.0073 as a small callout | 1:00 | Mirthula |
| 7 | Regional correlation rose most sharply in the sudden 2020 crash | Use `extra_credit_1/figures/ec1_f_widened_basket.png`; emphasize calm 0.282, 2008 0.326, 2020 0.539, 2022 0.196 and disclose the thin Paris/Korea/Switzerland baskets | 1:00 | Lakshmi |
| 8 | The biggest monthly volatility spikes were October 2008 and March 2020 | Use `assignment_5/part_2/figures/b2_monthly_absolute_return.png`; call out 4.82% and 4.67% | 1:00 | Lakshmi |
| 9 | A log scale recovered five growth stories hidden by the linear chart | Side-by-side `extra_credit_1/figures/ec1_a_before.png` and `extra_credit_1/figures/ec1_a_after.png`; name relative-vs-absolute scaling, label overlap, and reduced non-data ink | 1:30 | Lakshmi |
| 10 | Next: turn the validated patterns into an interactive dashboard | Power BI/Tableau plan, R wrangling lessons, open questions, limitations, and a clear close | 1:00 | Karthikeyan |

Planned speaking time: 9:00. Q&A buffer: 1:00.

## What to say on each section

### The question

Use one umbrella line instead of presenting three disconnected hypotheses:

> We are testing whether the diversification visible in a global stock dataset survives closer inspection across technology groups and crisis periods.

Then introduce the three checks:

1. Was the post-2023 technology rally broad or concentrated in selected chip/AI stocks?
2. Did different regions become more correlated in sudden crashes?
3. Did volatility and trading volume show the same panic-versus-slow-drawdown pattern?

### Data and approach

- Dataset: 230,111 daily observations, 49 tickers, 2006-01-02 to 2026-02-20.
- Python: exploratory analysis, hypotheses, crisis-period comparisons, statistical check, and advanced/interactive examples.
- R: replication of the EDA plus reshaping, date parsing, monthly grouping, and dplyr/data.table comparison.
- Comparability choices: use daily returns or index-to-100 rather than raw mixed-currency prices.
- Quality limits: staggered listing dates, different exchange calendars, highly unequal market coverage, and zero-volume rows.

### Key findings

1. The selected chip/AI group outperformed the selected broader-tech group by a wide margin. Keep the group definitions visible and avoid claiming this represents every AI-related company.
2. Cross-region correlation was highest in 2020. Widening the regional basket also made 2008 more distinct, but the regional evidence remains limited by the available tickers.
3. Monthly volatility independently peaks in the 2008 crisis and March 2020, supporting the panic-period result.

### Design evolution

- Before: the linear y-axis makes four of six indexed-growth lines look compressed because NVDA and AVGO dominate the absolute range.
- After: the log y-axis makes equal vertical distance represent equal proportional change, so every series remains legible.
- The redesign also removes top/right spines and separates overlapping direct labels.
- Name the principles explicitly: appropriate relative rather than absolute encoding, higher useful data-ink ratio, and improved pre-attentive/direct labeling.
- Do not create a separate extra-credit section; the brief explicitly allows the EC1 redesign to be folded into Design Evolution.

### What is next

Proposed dashboard direction:

- A Power BI or Tableau overview with filters for ticker group, region, and time period.
- An indexed-performance view for chip/AI versus broader tech.
- A crisis comparison view for calm, 2008, 2020, and 2022.
- A monthly volatility view using the long-form, month-binned R output.
- Use long-form data because one Ticker field can drive color, filters, and grouping cleanly.
- Keep date fields parsed and month-binned before import.

Open risks to say aloud:

- Paris has only one stock; Korea and Switzerland remain sector-narrow.
- The original Kaggle source page has been removed.
- Volume is share count and is affected by stock splits.
- The presentation supports a project-status conclusion, not a finished causal or forecasting claim.

## Rubric-focused rehearsal checklist

- [ ] The audience understands the central question within the first 2 minutes.
- [ ] Each finding has one chart, one number, one takeaway, and one limitation where needed.
- [ ] The before/after slide names real design principles, not cosmetic changes.
- [ ] All three members speak for at least 2.5 minutes overall.
- [ ] The rehearsed talk finishes by 9:00 without rushing.
- [ ] No slide contains more than one main claim.
- [ ] Chart labels and takeaways are readable from the back of the room.
- [ ] Data sources and date ranges appear on the relevant slides or in speaker notes.
- [ ] The final slide resolves the opening question and explains the dashboard next step.
- [ ] The exported PPTX/PDF is opened and checked before DigiiCampus submission.

## Source material

- Assignment brief: `half-way-presentation/docs/assignment/Project_Status_Presentation.docx`
- PDF copy: `half-way-presentation/docs/assignment/Project_Status_Presentation.pdf`
- Hypotheses/report: `assignment_3/docs/submissions/26120004_Team2_Assignment3.docx`
- R wrangling report: `assignment_5/part_2/docs/submissions/26120004_Team2_Assignment5_Part2.docx`
- Extra-credit report: `extra_credit_1/docs/submissions/26120004_Team2_Assignment-EC1.docx`
