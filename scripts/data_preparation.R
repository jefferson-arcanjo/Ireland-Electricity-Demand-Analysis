
# Load the electricity and weather datasets
electricity <- read.csv("data/time_series_60min_singleindex.csv")
weather <- read.csv("data/weather_data.csv")

# Keep only the Irish electricity data
ireland_electricity <- electricity[, c(
  "utc_timestamp",
  "IE_load_actual_entsoe_transparency",
  "IE_load_forecast_entsoe_transparency",
  "IE_wind_onshore_generation_actual"
)]

# Keep only the Irish weather data
ireland_weather <- weather[, c(
  "utc_timestamp",
  "IE_temperature",
  "IE_radiation_direct_horizontal",
  "IE_radiation_diffuse_horizontal"
)]

# Combine both datasets using the timestamps
ireland_data <- merge(
  ireland_electricity,
  ireland_weather,
  by = "utc_timestamp",
  all = FALSE
)

# Check the size and preview the combined data
dim(ireland_data)
head(ireland_data, 3)

# Check for missing values and duplicate timestamps
colSums(is.na(ireland_data))
sum(duplicated(ireland_data$utc_timestamp))

# Check the dates covered by the dataset
range(ireland_data$utc_timestamp)

# Check how many rows have missing values
sum(!complete.cases(ireland_data))
round(mean(!complete.cases(ireland_data)) * 100, 2)

# Remove rows with missing values
ireland_clean <- na.omit(ireland_data)

# Check the data after cleaning
dim(ireland_clean)
colSums(is.na(ireland_clean))
sum(duplicated(ireland_clean$utc_timestamp))

# Save the cleaned dataset as a CSV file
write.csv(
  ireland_clean,
  "data/ireland_electricity_clean.csv",
  row.names = FALSE
)

# Check that the file was saved
file.exists("data/ireland_electricity_clean.csv")

