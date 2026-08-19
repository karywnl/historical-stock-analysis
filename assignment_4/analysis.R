# assignment 4 - r eda
# mirrors assignment 2, same dataset, same questions, written in r

# part a: installation and setup
# install.packages() only needs to run once per machine, commented out here
# since it has already been run. library() runs every session.

# install.packages(c('tidyverse', 'data.table', 'lubridate', 'reshape2'))

library(tidyverse)
library(data.table)
library(lubridate)
library(reshape2)

# part c0: setup and data overview

# c0.1 load the dataset and report its shape
df <- read.csv('data/stock_data.csv')

dim(df)
names(df)
str(df)
head(df)

# c0.2 summary statistics for numeric columns
numeric_cols <- c('Open', 'High', 'Low', 'Close', 'Adj.Close', 'Volume')
summary(df[numeric_cols])

# range and mean minus median for each numeric column, same check as the python eda
col_range <- sapply(df[numeric_cols], function(x) max(x) - min(x))
col_mean_minus_median <- sapply(df[numeric_cols], function(x) mean(x) - median(x))
data.frame(range = col_range, mean_minus_median = col_mean_minus_median)

# c0.3 quantify missing data by column
colSums(is.na(df))

# part c1: univariate exploration

# c1.1 distribution of the key numeric variable
# same choice as the python eda: daily return, since raw price mixes currencies
# across the 49 tickers and cannot be compared directly on one axis

df <- df %>% arrange(Ticker, Date)
df <- df %>%
  group_by(Ticker) %>%
  mutate(Daily.Return = Adj.Close / lag(Adj.Close) - 1) %>%
  ungroup()

returns <- df$Daily.Return[!is.na(df$Daily.Return)]
summary(returns)

# using ggplot2 for this one, our first of at least two required graphics systems
fig1 <- ggplot(data.frame(Daily.Return = returns), aes(x = Daily.Return)) +
  geom_histogram(bins = 200, fill = '#4C72B0') +
  coord_cartesian(xlim = c(-0.2, 0.2)) +
  labs(
    title = 'Figure 1: distribution of daily returns, all 49 tickers, 2006-01-02 to 2026-02-20',
    x = 'Daily return (fraction, 0.05 means plus 5 percent)',
    y = 'Number of ticker-days'
  )
fig1
ggsave('assignment_4/figures/fig1_daily_return_hist.png', fig1, width = 8, height = 4, dpi = 150)

# c1.2 category counts for a key categorical variable
# same categorical variable as the python eda: market, derived from ticker suffix
# using base r here, our second graphics system, different from ggplot2 above

get_market <- function(ticker) {
  if (endsWith(ticker, '.KS')) {
    return('Korea')
  } else if (endsWith(ticker, '.HK')) {
    return('Hong Kong')
  } else if (endsWith(ticker, '.SW')) {
    return('Switzerland')
  } else if (endsWith(ticker, '.PA')) {
    return('Paris')
  } else if (endsWith(ticker, '.SR')) {
    return('Saudi Arabia')
  } else {
    return('United States')
  }
}

df$Market <- sapply(df$Ticker, get_market)
market_counts <- table(df$Market)
market_counts <- sort(market_counts, decreasing = TRUE)
market_counts

png('assignment_4/figures/fig2_market_counts.png', width = 800, height = 500)
par(mar = c(8, 5, 4, 2))
barplot(market_counts,
        main = 'Figure 2: row count by market, stock data 2006-01-02 to 2026-02-20',
        ylab = 'Row count', col = '#4C72B0', las = 2)
mtext('Market', side = 1, line = 6)
dev.off()

# c1.3 box plot for outliers in the key numeric variable (optional / bonus)
# checking daily return again, the same variable as c1.1

fig3 <- ggplot(data.frame(Daily.Return = returns), aes(x = Daily.Return)) +
  geom_boxplot(fill = '#4C72B0') +
  labs(
    title = 'Figure 3: box plot of daily returns, all 49 tickers, 2006-01-02 to 2026-02-20',
    x = 'Daily return (fraction, 0.05 means plus 5 percent)'
  ) +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
fig3
ggsave('assignment_4/figures/fig3_daily_return_box.png', fig3, width = 8, height = 3, dpi = 150)

q1 <- quantile(returns, 0.25)
q3 <- quantile(returns, 0.75)
iqr <- q3 - q1
lower_fence <- q1 - 1.5 * iqr
upper_fence <- q3 + 1.5 * iqr

outlier_share <- mean(returns < lower_fence | returns > upper_fence)
cat(sprintf('outlier fence: %.4f to %.4f\n', lower_fence, upper_fence))
cat(sprintf('share of days outside the fence: %.2f%%\n', outlier_share * 100))

# five most negative and five most positive return days, same check as the python eda
df_returns <- df[!is.na(df$Daily.Return), ]
df_returns <- df_returns %>% arrange(Daily.Return)
head(df_returns[, c('Date', 'Ticker', 'Daily.Return')], 5)
tail(df_returns[, c('Date', 'Ticker', 'Daily.Return')], 5)

# part c2: relationships between variables

# c2.1 scatter plot of two related numeric variables
# same question as the python eda: does bigger trading volume come with bigger price moves
# volume is log scaled since it spans several orders of magnitude, and we sample
# 3000 points instead of plotting all 230062, same as the python version

plot_df <- df[!is.na(df$Daily.Return), ]
plot_df$Abs.Daily.Return <- abs(plot_df$Daily.Return)

set.seed(42)
sample_df <- plot_df[sample(nrow(plot_df), 3000), ]

correlation <- cor(plot_df$Volume, plot_df$Abs.Daily.Return)
cat(sprintf('pearson correlation, volume vs absolute daily return, full data: %.3f\n', correlation))

fig4 <- ggplot(sample_df, aes(x = Volume, y = Abs.Daily.Return)) +
  geom_point(alpha = 0.4, size = 1.5, color = '#4C72B0') +
  scale_x_log10() +
  labs(
    title = 'Figure 4: trading volume vs size of daily price move, 3,000 sampled ticker-days',
    x = 'Volume, shares traded, log scale',
    y = 'Absolute daily return (fraction)'
  )
fig4
ggsave('assignment_4/figures/fig4_volume_vs_move.png', fig4, width = 8, height = 5, dpi = 150)

# c2.2 correlation heatmap
# same eight tickers as the python eda: five chip names, two broader tech names,
# and one non-us name (lvmh) to get a first look at cross region correlation

tickers_of_interest <- c('NVDA', 'AVGO', 'TSM', 'ASML', 'AMD', 'AAPL', 'MSFT', 'MC.PA')
returns_subset <- df[df$Ticker %in% tickers_of_interest, c('Date', 'Ticker', 'Daily.Return')]
returns_wide <- dcast(returns_subset, Date ~ Ticker, value.var = 'Daily.Return')

corr_matrix <- cor(returns_wide[, tickers_of_interest], use = 'pairwise.complete.obs')
round(corr_matrix, 3)

corr_long <- melt(corr_matrix)
names(corr_long) <- c('Ticker1', 'Ticker2', 'Correlation')

fig5 <- ggplot(corr_long, aes(x = Ticker1, y = Ticker2, fill = Correlation)) +
  geom_tile() +
  geom_text(aes(label = round(Correlation, 2)), size = 3) +
  scale_fill_gradient2(low = '#C44E52', mid = 'white', high = '#4C72B0', midpoint = 0, limits = c(-1, 1)) +
  labs(title = 'Figure 5: daily return correlation, eight tickers, full overlapping history', x = '', y = '') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
fig5
ggsave('assignment_4/figures/fig5_correlation_heatmap.png', fig5, width = 7, height = 6, dpi = 150)

# c2.3 recreate one plot above using a second r graphics system
# recreating figure 4, volume vs size of daily move, in lattice this time
# ggplot2 and base r were the first two systems used above, lattice is the third

library(lattice)

fig6 <- xyplot(Abs.Daily.Return ~ Volume, data = sample_df,
               scales = list(x = list(log = 10)),
               xlab = 'Volume, shares traded, log scale',
               ylab = 'Absolute daily return (fraction)',
               main = 'Figure 6: trading volume vs size of daily price move, lattice version, same 3,000 sampled ticker-days',
               col = '#4C72B0', alpha = 0.4, pch = 16)
fig6

png('assignment_4/figures/fig6_volume_vs_move_lattice.png', width = 900, height = 600)
print(fig6)
dev.off()

# part c3: group and categorical comparisons

# c3.1 compare a numeric outcome across groups
# grouping by market, the same categorical variable as c1.2, comparing mean and
# standard deviation of daily return across groups

market_stats <- df_returns %>%
  group_by(Market) %>%
  summarise(mean_return = mean(Daily.Return), sd_return = sd(Daily.Return)) %>%
  arrange(desc(mean_return))
market_stats

fig7 <- ggplot(market_stats, aes(x = reorder(Market, -mean_return), y = mean_return)) +
  geom_col(fill = '#4C72B0') +
  labs(
    title = 'Figure 7: mean daily return by market, 2006-01-02 to 2026-02-20',
    x = 'Market', y = 'Mean daily return (fraction)'
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
fig7
ggsave('assignment_4/figures/fig7_mean_return_by_market.png', fig7, width = 8, height = 4, dpi = 150)

# c3.2 key variable over time
# same six tickers and same rebase logic as the python eda: price indexed to 100
# so different starting prices and currencies do not distort the comparison

chart_tickers <- c('NVDA', 'AVGO', 'TSM', 'ASML', 'AAPL', 'MSFT')
prices_subset <- df[df$Ticker %in% chart_tickers, c('Date', 'Ticker', 'Adj.Close')]
prices_subset$Date <- ymd(prices_subset$Date)
prices_wide <- dcast(prices_subset, Date ~ Ticker, value.var = 'Adj.Close')

# broadcom is the latest starter of this group, so the first row with no na
# anywhere is the rebase point, same logic as the python eda
complete_rows <- prices_wide[complete.cases(prices_wide), ]
rebase_date <- min(complete_rows$Date)
cat('rebase date:', as.character(rebase_date), '\n')

indexed <- prices_wide[prices_wide$Date >= rebase_date, ]
rebase_values <- indexed[1, chart_tickers]
for (ticker in chart_tickers) {
  indexed[[ticker]] <- indexed[[ticker]] / rebase_values[[ticker]] * 100
}
tail(indexed)

indexed_long <- melt(indexed, id.vars = 'Date', variable.name = 'Ticker', value.name = 'Indexed.Price')
last_points <- indexed_long %>% group_by(Ticker) %>% filter(Date == max(Date)) %>% ungroup()

# aapl, asml, and tsm end up close together, so their end-of-line labels
# overlap without a small manual nudge apart
label_nudge <- c(NVDA = 0, AVGO = 0, TSM = 300, ASML = 900, AAPL = -300, MSFT = 0)
last_points$Label.Y <- last_points$Indexed.Price + label_nudge[as.character(last_points$Ticker)]

chip_colors <- c(
  NVDA = '#4C72B0', AVGO = '#55A868', TSM = '#8172B2',
  ASML = '#C44E52', AAPL = '#937860', MSFT = '#CCB974'
)

fig8 <- ggplot(indexed_long, aes(x = Date, y = Indexed.Price, color = Ticker)) +
  geom_line(linewidth = 0.8) +
  geom_text(data = last_points, aes(y = Label.Y, label = Ticker), hjust = -0.1, size = 3.5) +
  scale_color_manual(values = chip_colors) +
  scale_x_date(expand = expansion(mult = c(0.02, 0.12))) +
  labs(
    title = paste0('Figure 8: price indexed to 100 at ', rebase_date, ', chip names vs apple and microsoft'),
    x = 'Date', y = 'Indexed price, 100 = value on rebase date'
  ) +
  theme(legend.position = 'none')
fig8
ggsave('assignment_4/figures/fig8_indexed_price.png', fig8, width = 10, height = 6, dpi = 150)
