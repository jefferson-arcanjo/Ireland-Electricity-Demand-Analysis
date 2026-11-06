
# Ireland Electricity Demand Analysis

# 1. Load the datasets
electricity <- read.csv("data/time_series_60min_singleindex.csv")
weather <- read.csv("data/weather_data.csv")

# 2. Check dataset dimensions
dim(electricity)
dim(weather)

# 3. Check data structure
str(electricity[, 1:5])
str(weather[, 1:5])

# 4. Identify Irish variables
grep("^IE_", names(electricity), value = TRUE)
grep("^IE_", names(weather), value = TRUE)

# 5. Select Irish electricity and weather variables
ireland_electricity <- electricity[, c(
  "utc_timestamp",
  "IE_load_actual_entsoe_transparency",
  "IE_load_forecast_entsoe_transparency",
  "IE_wind_onshore_generation_actual"
)]

ireland_weather <- weather[, c(
  "utc_timestamp",
  "IE_temperature",
  "IE_radiation_direct_horizontal",
  "IE_radiation_diffuse_horizontal"
)]

# 6. Inspect the selected datasets
dim(ireland_electricity)
dim(ireland_weather)

head(ireland_electricity, 3)
head(ireland_weather, 3)

# 7. Check summary statistics
summary(ireland_electricity)
summary(ireland_weather)
