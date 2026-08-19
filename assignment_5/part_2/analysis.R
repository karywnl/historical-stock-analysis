# Assignment 5 - Part 2
# Data wrangling with R using the historical stock dataset.

library(tidyverse)
library(data.table)
library(lubridate)

figure_dir <- "assignment_5/part_2/figures"
table_dir <- "assignment_5/part_2/tables"
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)

# Load and prepare the same dataset used in Assignments 2 and 4.
stocks <- read.csv("data/stock_data.csv") %>%
  mutate(Date = lubridate::ymd(Date)) %>%
  arrange(Ticker, Date) %>%
  group_by(Ticker) %>%
  mutate(Daily.Return = Adj.Close / lag(Adj.Close) - 1) %>%
  ungroup()

get_market <- function(ticker) {
  case_when(
    endsWith(ticker, ".KS") ~ "Korea",
    endsWith(ticker, ".HK") ~ "Hong Kong",
    endsWith(ticker, ".SW") ~ "Switzerland",
    endsWith(ticker, ".PA") ~ "Paris",
    endsWith(ticker, ".SR") ~ "Saudi Arabia",
    TRUE ~ "United States"
  )
}

stocks <- stocks %>%
  mutate(Market = get_market(Ticker))

# B.1 Reshape the data.
# Create one monthly observation for four US-listed stocks, then index each
# series to 100 so their different price levels can be compared honestly.
selected_tickers <- c("AAPL", "MSFT", "NVDA", "AVGO")

monthly_long_source <- stocks %>%
  filter(Ticker %in% selected_tickers, lubridate::year(Date) == 2025) %>%
  mutate(Month = lubridate::floor_date(Date, unit = "month")) %>%
  group_by(Ticker, Month) %>%
  slice_max(Date, n = 1, with_ties = FALSE) %>%
  ungroup() %>%
  group_by(Ticker) %>%
  arrange(Ticker, Month) %>%
  mutate(Indexed.Price = Adj.Close / dplyr::first(Adj.Close) * 100) %>%
  ungroup() %>%
  select(Month, Ticker, Indexed.Price)

monthly_wide <- monthly_long_source %>%
  pivot_wider(names_from = Ticker, values_from = Indexed.Price) %>%
  arrange(Month)

monthly_long <- monthly_wide %>%
  pivot_longer(
    cols = all_of(selected_tickers),
    names_to = "Ticker",
    values_to = "Indexed.Price"
  ) %>%
  arrange(Month, Ticker)

write.csv(monthly_wide, file.path(table_dir, "b1_wide.csv"), row.names = FALSE)
write.csv(monthly_long, file.path(table_dir, "b1_long.csv"), row.names = FALSE)

stock_colors <- c(
  AAPL = "#4C78A8",
  MSFT = "#59A14F",
  NVDA = "#E15759",
  AVGO = "#B279A2"
)

b1_plot <- ggplot(
  monthly_long,
  aes(x = Month, y = Indexed.Price, color = Ticker)
) +
  geom_hline(yintercept = 100, color = "#B8B8B8", linewidth = 0.4) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = stock_colors) +
  scale_x_date(date_breaks = "2 months", date_labels = "%b") +
  labs(
    title = "Monthly adjusted prices in 2025, indexed to 100 in January",
    subtitle = "Long format maps one Ticker column directly to line color",
    x = "Month",
    y = "Indexed adjusted price",
    color = "Ticker",
    caption = "Source: data/stock_data.csv. Month-end observations; January 2025 = 100 for each ticker."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    legend.position = "top"
  )

ggsave(
  file.path(figure_dir, "b1_reshape_indexed_prices.png"),
  b1_plot,
  width = 8.2,
  height = 4.7,
  dpi = 180
)

# B.2 Parse and use the date field.
# ymd() parses the original character field. The extracted components below
# demonstrate year, month, and weekday, while floor_date() defines monthly bins.
parsed_date_sample <- stocks %>%
  select(Date, Ticker) %>%
  slice_head(n = 6) %>%
  mutate(
    Year = lubridate::year(Date),
    Month = lubridate::month(Date, label = TRUE, abbr = FALSE),
    Weekday = lubridate::wday(Date, label = TRUE, abbr = FALSE)
  )

write.csv(
  parsed_date_sample,
  file.path(table_dir, "b2_parsed_date_sample.csv"),
  row.names = FALSE
)

# First calculate within each ticker-month, then average across tickers. This
# gives each available ticker equal weight instead of letting markets with more
# tickers dominate the monthly volatility measure.
monthly_volatility <- stocks %>%
  filter(!is.na(Daily.Return)) %>%
  mutate(Month = lubridate::floor_date(Date, unit = "month")) %>%
  group_by(Ticker, Month) %>%
  summarise(
    Mean.Abs.Return = mean(abs(Daily.Return)),
    .groups = "drop"
  ) %>%
  group_by(Month) %>%
  summarise(
    Mean.Abs.Return = mean(Mean.Abs.Return),
    Tickers = n(),
    .groups = "drop"
  )

top_volatility_months <- monthly_volatility %>%
  slice_max(Mean.Abs.Return, n = 5, with_ties = FALSE) %>%
  arrange(desc(Mean.Abs.Return))

write.csv(
  monthly_volatility,
  file.path(table_dir, "b2_monthly_volatility.csv"),
  row.names = FALSE
)
write.csv(
  top_volatility_months,
  file.path(table_dir, "b2_top_volatility_months.csv"),
  row.names = FALSE
)

b2_plot <- ggplot(
  monthly_volatility,
  aes(x = Month, y = Mean.Abs.Return)
) +
  geom_line(color = "#4C78A8", linewidth = 0.75) +
  geom_point(
    data = top_volatility_months,
    color = "#E15759",
    size = 2.2
  ) +
  scale_x_date(date_breaks = "2 years", date_labels = "%Y") +
  scale_y_continuous(labels = scales::label_percent(accuracy = 0.1)) +
  labs(
    title = "Average absolute daily return by month, 2006-2026",
    subtitle = "Equal-weighted across the tickers available in each month; five highest months highlighted",
    x = "Month",
    y = "Mean absolute daily return",
    caption = "Source: data/stock_data.csv. Monthly bins created with lubridate::floor_date()."
  ) +
  theme_minimal(base_size = 11) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold")
  )

ggsave(
  file.path(figure_dir, "b2_monthly_absolute_return.png"),
  b2_plot,
  width = 8.2,
  height = 4.7,
  dpi = 180
)

# B.3 Repeat Assignment 4 C3.1 with dplyr and data.table.
returns_by_market <- stocks %>%
  filter(!is.na(Daily.Return))

market_stats_dplyr <- returns_by_market %>%
  group_by(Market) %>%
  summarise(
    mean_return = mean(Daily.Return),
    sd_return = sd(Daily.Return),
    observations = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_return))

returns_dt <- as.data.table(copy(returns_by_market))
market_stats_dt <- returns_dt[
  , .(
    mean_return = mean(Daily.Return),
    sd_return = sd(Daily.Return),
    observations = .N
  ),
  by = Market
][order(-mean_return)]

write.csv(
  market_stats_dplyr,
  file.path(table_dir, "b3_market_stats_dplyr.csv"),
  row.names = FALSE
)
write.csv(
  as.data.frame(market_stats_dt),
  file.path(table_dir, "b3_market_stats_data_table.csv"),
  row.names = FALSE
)

comparison_ok <- isTRUE(all.equal(
  as.data.frame(market_stats_dplyr),
  as.data.frame(market_stats_dt),
  check.attributes = FALSE,
  tolerance = 1e-12
))

cat("B.1 wide form:\n")
print(monthly_wide)
cat("\nB.1 long form, first 12 rows:\n")
print(head(monthly_long, 12))
cat("\nB.2 parsed date sample:\n")
print(parsed_date_sample)
cat("\nB.2 five highest-volatility months:\n")
print(top_volatility_months)
cat("\nB.3 dplyr result:\n")
print(market_stats_dplyr)
cat("\nB.3 data.table result:\n")
print(market_stats_dt)
cat("\nThe dplyr and data.table results match:", comparison_ok, "\n")
