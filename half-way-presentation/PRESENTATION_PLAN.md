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

## Actual 11-slide story (deck as submitted)

Speaking sections follow the deck's own three parts: Mirthula covers the
introduction through hypothesis setup (5 slides), Karthikeyan covers the
three hypothesis-evidence slides (3 slides), Lakshmi covers the conclusion
(3 slides). This keeps everyone at roughly the same amount of talk time
even though the slide counts differ, because the intro slides run shorter
and the hypothesis/conclusion slides run longer.

| Slide | Takeaway-style title | Content and existing asset | Time | Speaker |
|---|---|---|---:|---|
| 1 | Historical Stock Analysis: does diversification survive a closer look? | Team 2, three members, one-line dataset description | 0:20 | Mirthula |
| 2 | Each row is one company on one trading day | 230,111 rows, 8 columns, 0 missing values, 2006-01-02 to 2026-02-20; the Samsung row shows why raw prices aren't comparable | 0:35 | Mirthula |
| 3 | The file is complete, but coverage is uneven | `assignment_4/figures/fig2_market_counts.png`; 0 missing fields, 0 duplicate Date-Ticker pairs, 1,706 zero-volume rows; US dominance; the returns/index-to-100 decision; say the Python (explore/test) vs R (replicate/reshape) split out loud here | 0:40 | Mirthula |
| 4 | Three testable claims frame everything that follows | NEW slide: define a hypothesis as a testable claim, then state H1/H2/H3 in plain language before any evidence appears | 0:35 | Mirthula |
| 5 | Two ticker groups, four market periods make it testable | Chip/AI vs broader-tech tickers; calm/2008/2020/2022 periods; correlation defined in one line | 0:35 | Mirthula |
| 6 | Selected chip/AI stocks gained 549%; broader tech gained 168% | Use `assignment_3/figures/figure_a_ai_rally.png`; 0.26% vs 0.14% mean daily return and p = 0.0073 | 0:55 | Karthikeyan |
| 7 | Regional correlation rose most sharply in the sudden 2020 crash | Use `extra_credit_1/figures/ec1_f_widened_basket.png`; calm 0.282, 2008 0.326, 2020 0.539; disclose the thin Paris/Korea/Switzerland baskets | 0:55 | Karthikeyan |
| 8 | The biggest monthly volatility spikes were October 2008 and March 2020 | Use `assignment_5/part_2/figures/b2_monthly_absolute_return.png`; call out 4.82% and 4.67% | 0:55 | Karthikeyan |
| 9 | A log scale recovered growth stories hidden by the linear chart | Side-by-side `extra_credit_1/figures/ec1_a_before.png` and `extra_credit_1/figures/ec1_a_after.png`; name relative-vs-absolute scaling, label overlap, and reduced non-data ink | 0:55 | Lakshmi |
| 10 | Diversification is thinner when it matters most | Synthesizes H1-H3; closes with what we can/cannot claim (patterns, not causality or forecasting) and the regional/volume limits | 0:50 | Lakshmi |
| 11 | Next: turn the validated patterns into an interactive dashboard | Power BI/Tableau plan, R wrangling lessons, open risks, a clear close | 0:45 | Lakshmi |

Planned speaking time: 8:00. Q&A buffer: 2:00.

Per-speaker total: Mirthula 2:45, Karthikeyan 2:45, Lakshmi 2:30.

Note: the assignment brief says "aim for 8-10 slides"; this deck runs 11.
That's judged worth it to keep the hypothesis-claims slide and the full
data-audit slide intact rather than cutting real content to hit the
number exactly — but if time is tight in rehearsal, folding slide 4 back
into slide 5 is the next easiest cut.

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
