
#Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Check the final dataset
dim(ireland)
colSums(is.na(ireland))

# Calculate electricity demand statistics
demand <- ireland$IE_load_actual_entsoe_transparency

mean(demand)
median(demand)
min(demand)
max(demand)
sd(demand)

# Compare actual and forecast demand
forecast <- ireland$IE_load_forecast_entsoe_transparency

cor(demand, forecast)

# Calculate forecast errors
forecast_error <- forecast - demand

mean(forecast_error)
mean(abs(forecast_error))

# Check relationships with weather and wind
cor(demand, ireland$IE_temperature)
cor(demand, ireland$IE_wind_onshore_generation_actual)
cor(demand, ireland$IE_radiation_direct_horizontal)

# Calculate average demand by year
ireland$datetime <- as.POSIXct(
  ireland$utc_timestamp,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

ireland$year <- format(ireland$datetime, "%Y")

yearly_demand <- aggregate(
  IE_load_actual_entsoe_transparency ~ year,
  data = ireland,
  FUN = mean
)

print(yearly_demand)

# Summarise the PCA results
pca_data <- ireland[, c(
  "IE_load_actual_entsoe_transparency",
  "IE_load_forecast_entsoe_transparency",
  "IE_wind_onshore_generation_actual",
  "IE_temperature",
  "IE_radiation_direct_horizontal",
  "IE_radiation_diffuse_horizontal"
)]

pca_result <- prcomp(
  pca_data,
  center = TRUE,
  scale. = TRUE
)

summary(pca_result)

