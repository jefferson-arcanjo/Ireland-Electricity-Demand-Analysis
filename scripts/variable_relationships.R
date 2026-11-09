

# Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Check the main variables
summary(ireland[, c(
  "IE_load_actual_entsoe_transparency",
  "IE_temperature",
  "IE_wind_onshore_generation_actual",
  "IE_load_forecast_entsoe_transparency"
)])

# Check the relationship between temperature and demand
plot(
  ireland$IE_temperature,
  ireland$IE_load_actual_entsoe_transparency,
  main = "Temperature vs Electricity Demand",
  xlab = "Temperature (°C)",
  ylab = "Electricity Demand (MW)",
  col = "lightblue",
  pch = 16,
  cex = 0.4
)

# Calculate the correlation between temperature and demand
cor(
  ireland$IE_temperature,
  ireland$IE_load_actual_entsoe_transparency
)

# Check the relationship between wind generation and demand
plot(
  ireland$IE_wind_onshore_generation_actual,
  ireland$IE_load_actual_entsoe_transparency,
  main = "Wind Generation vs Electricity Demand",
  xlab = "Wind Generation (MW)",
  ylab = "Electricity Demand (MW)",
  col = "darkgreen",
  pch = 16,
  cex = 0.4
)

# Calculate the correlation between wind and demand
cor(
  ireland$IE_wind_onshore_generation_actual,
  ireland$IE_load_actual_entsoe_transparency
)

# Compare forecast and actual electricity demand
plot(
  ireland$IE_load_forecast_entsoe_transparency,
  ireland$IE_load_actual_entsoe_transparency,
  main = "Forecast vs Actual Electricity Demand",
  xlab = "Forecast Demand (MW)",
  ylab = "Actual Demand (MW)",
  col = "steelblue",
  pch = 16,
  cex = 0.4
)

# Calculate the correlation between forecast and actual demand
cor(
  ireland$IE_load_forecast_entsoe_transparency,
  ireland$IE_load_actual_entsoe_transparency
)

#  Create a correlation matrix
numeric_data <- ireland[, c(
  "IE_load_actual_entsoe_transparency",
  "IE_load_forecast_entsoe_transparency",
  "IE_wind_onshore_generation_actual",
  "IE_temperature",
  "IE_radiation_direct_horizontal",
  "IE_radiation_diffuse_horizontal"
)]

correlation_matrix <- cor(numeric_data)

round(correlation_matrix, 2)

#  Check the difference between forecast and actual demand
ireland$forecast_error <-
  ireland$IE_load_forecast_entsoe_transparency -
  ireland$IE_load_actual_entsoe_transparency

summary(ireland$forecast_error)

#  Plot the forecast errors
hist(
  ireland$forecast_error,
  main = "Electricity Demand Forecast Errors",
  xlab = "Forecast Error (MW)",
  col = "lightblue",
  border = "white"
)

