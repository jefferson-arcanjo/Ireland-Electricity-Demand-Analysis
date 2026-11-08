
# Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Check the dataset
dim(ireland)
head(ireland, 3)
str(ireland)

# Check summary statistics for electricity demand
summary(ireland$IE_load_actual_entsoe_transparency)

sd(ireland$IE_load_actual_entsoe_transparency)

# Create a histogram of electricity demand
hist(
  ireland$IE_load_actual_entsoe_transparency,
  main = "Electricity Demand in Ireland",
  xlab = "Electricity Demand (MW)",
  col = "lightblue",
  border = "white"
)

# Create a boxplot to check for outliers
boxplot(
  ireland$IE_load_actual_entsoe_transparency,
  main = "Electricity Demand - Boxplot",
  ylab = "Electricity Demand (MW)",
  col = "lightgreen"
)

# Convert timestamps into dates
ireland$datetime <- as.POSIXct(
  ireland$utc_timestamp,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

# Plot electricity demand over time
plot(
  ireland$datetime,
  ireland$IE_load_actual_entsoe_transparency,
  type = "l",
  main = "Electricity Demand Over Time",
  xlab = "Year",
  ylab = "Electricity Demand (MW)",
  col = "blue"
)

# Calculate average electricity demand by year
ireland$year <- format(ireland$datetime, "%Y")

yearly_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ year,
  data = ireland,
  FUN = mean
)

print(yearly_demand)

# Plot average electricity demand by year
barplot(
  yearly_demand$IE_load_actual_entsoe_transparency,
  names.arg = yearly_demand$year,
  main = "Average Electricity Demand by Year",
  xlab = "Year",
  ylab = "Average Demand (MW)",
  col = "steelblue"
)

# Calculate average electricity demand by month
ireland$month <- format(ireland$datetime, "%Y-%m")

monthly_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ month,
  data = ireland,
  FUN = mean
)

# Plot average monthly electricity demand
plot(
  as.Date(paste0(monthly_demand$month, "-01")),
  monthly_demand$IE_load_actual_entsoe_transparency,
  type = "l",
  main = "Average Monthly Electricity Demand",
  xlab = "Year",
  ylab = "Average Demand (MW)",
  col = "blue",
  lwd = 2
)
