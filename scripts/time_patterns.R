
# Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Convert timestamps into dates
ireland$datetime <- as.POSIXct(
  ireland$utc_timestamp,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

# Create day and month columns
ireland$day <- factor(
  weekdays(ireland$datetime),
  levels = c("Monday", "Tuesday", "Wednesday",
             "Thursday", "Friday", "Saturday", "Sunday")
)

ireland$month <- as.integer(format(ireland$datetime, "%m"))

# Calculate average electricity demand by day
daily_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ day,
  data = ireland,
  FUN = mean
)

# Plot average electricity demand by day
barplot(
  daily_demand$IE_load_actual_entsoe_transparency,
  names.arg = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
  main = "Average Electricity Demand by Day",
  xlab = "Day of Week",
  ylab = "Average Demand (MW)",
  col = "lightblue",
  las = 1,
  ylim = c(0, 3500)
)

# Calculate average electricity demand by month
monthly_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ month,
  data = ireland,
  FUN = mean
)

print(monthly_demand)


# Plot average electricity demand by month
barplot(
  monthly_demand$IE_load_actual_entsoe_transparency,
  names.arg = month.abb[monthly_demand$month],
  main = "Average Electricity Demand by Month",
  xlab = "Month",
  ylab = "Average Demand (MW)",
  col = "steelblue",
  ylim = c(0, 4000)
)


# Create a season column
ireland$season <- ifelse(
  ireland$month %in% c(12, 1, 2), "Winter",
  ifelse(
    ireland$month %in% c(3, 4, 5), "Spring",
    ifelse(
      ireland$month %in% c(6, 7, 8),
      "Summer", "Autumn"
    )
  )
)

# Calculate average electricity demand by season
seasonal_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ season,
  data = ireland,
  FUN = mean
)

print(seasonal_demand)


# Plot average electricity demand by season
barplot(
  seasonal_demand$IE_load_actual_entsoe_transparency,
  names.arg = seasonal_demand$season,
  main = "Average Electricity Demand by Season",
  xlab = "Season",
  ylab = "Average Demand (MW)",
  col = "lightgreen",
  ylim = c(0, 4000)
)


# Compare electricity demand across seasons
boxplot(
  IE_load_actual_entsoe_transparency ~ season,
  data = ireland,
  main = "Electricity Demand by Season",
  xlab = "Season",
  ylab = "Electricity Demand (MW)",
  col = "lightblue"
)

