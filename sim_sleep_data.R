set.seed(1234)

# Group sizes
n1 <- 40
n2 <- 60

# Target parameters
mean1 <- 9.8
sd1 <- 1.15

mean2 <- 9.0
sd2 <- 1.29

# ----------------------
# Group 1: approximately normal
# ----------------------
g1 <- rnorm(n1)

# Rescale to exact mean and SD
g1 <- (g1 - mean(g1)) / sd(g1) * sd1 + mean1

# ----------------------
# Group 2: left-skewed (poorer sleep)
# ----------------------
shape <- 4
gamma_raw <- rgamma(n2, shape = shape)

# Reflect to obtain left skew
g2 <- max(gamma_raw) - gamma_raw

# Rescale to exact mean and SD
g2 <- (g2 - mean(g2)) / sd(g2) * sd2 + mean2

# ----------------------
# Combine into dataset
# ----------------------
sleep_data <- data.frame(
  Group = c(rep("Group1", n1), rep("Group2", n2)),
  SleepHours = c(g1, g2)
)

# Check results
aggregate(SleepHours ~ Group, sleep_data,
          function(x) c(mean = mean(x),
                        sd = sd(x)))



library(ggplot2)

ggplot(sleep_data,
       aes(x = SleepHours, fill = Group)) +
  geom_histogram(alpha = 0.6,
                 bins = 12,
                 position = "identity") +
  facet_wrap(~Group) +
  theme_minimal()




set.seed(123)

B <- 10000

# Observed statistic
obs_mean_diff <- with(sleep_data,
                      mean(SleepHours[Group == "Group1"]) -
                        mean(SleepHours[Group == "Group2"]))

perm_mean_diff <- replicate(B, {
  perm_group <- sample(sleep_data$Group)
  
  mean(sleep_data$SleepHours[perm_group == "Group1"]) -
    mean(sleep_data$SleepHours[perm_group == "Group2"])
})

# Two-sided p-value
p_mean <- mean(abs(perm_mean_diff) >= abs(obs_mean_diff))

p_mean

# Observed statistic
obs_median_diff <- with(sleep_data,
                        median(SleepHours[Group == "Group1"]) -
                          median(SleepHours[Group == "Group2"]))

perm_median_diff <- replicate(B, {
  perm_group <- sample(sleep_data$Group)
  
  median(sleep_data$SleepHours[perm_group == "Group1"]) -
    median(sleep_data$SleepHours[perm_group == "Group2"])
})

p_median <- mean(abs(perm_median_diff) >= abs(obs_median_diff))

p_median



perm_test <- function(y, group, stat_fun, B = 10000) {
  
  obs <- stat_fun(y[group == "Group1"]) -
    stat_fun(y[group == "Group2"])
  
  perm_stats <- replicate(B, {
    perm_group <- sample(group)
    
    stat_fun(y[perm_group == "Group1"]) -
      stat_fun(y[perm_group == "Group2"])
  })
  
  p <- mean(abs(perm_stats) >= abs(obs))
  
  list(
    observed = obs,
    p.value = p,
    perm_stats = perm_stats
  )
}

# Mean
mean_test <- perm_test(
  sleep_data$SleepHours,
  sleep_data$Group,
  mean
)

# Median
median_test <- perm_test(
  sleep_data$SleepHours,
  sleep_data$Group,
  median
)

# First quartile
q25_test <- perm_test(
  sleep_data$SleepHours,
  sleep_data$Group,
  function(x) quantile(x, 0.25)
)

mean_test$p.value
median_test$p.value
q25_test$p.value

# Round sleep durations to 1 decimal place
sleep_data$SleepHours <- round(sleep_data$SleepHours, 1)

# Verify means and SDs after rounding
aggregate(SleepHours ~ Group, sleep_data,
          function(x) c(mean = mean(x),
                        sd = sd(x)))

# Save to CSV
write.csv(sleep_data,
          file = "sleep_data.csv",
          row.names = FALSE)
