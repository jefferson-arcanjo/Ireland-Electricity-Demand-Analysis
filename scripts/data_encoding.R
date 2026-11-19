
# Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Convert the timestamp into a date
ireland$datetime <- as.POSIXct(
  ireland$utc_timestamp,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

# Create the day column
ireland$day <- factor(
  weekdays(ireland$datetime),
  levels = c("Monday", "Tuesday", "Wednesday",
             "Thursday", "Friday", "Saturday", "Sunday")
)

# Encode days from 1 to 7
ireland$day_encoded <- as.integer(ireland$day)

# Encode weekdays and weekends
ireland$weekend <- ifelse(
  ireland$day_encoded %in% c(6, 7), 1, 0
)

#  Create the month and season columns
ireland$month <- as.integer(format(ireland$datetime, "%m"))

ireland$season <- ifelse(
  ireland$month %in% c(12, 1, 2), "Winter",
  ifelse(
    ireland$month %in% c(3, 4, 5), "Spring",
    ifelse(ireland$month %in% c(6, 7, 8),
           "Summer", "Autumn")
  )
)

# Encode seasons from 1 to 4
ireland$season_encoded <- match(
  ireland$season,
  c("Winter", "Spring", "Summer", "Autumn")
)

# Create dummy variables for seasons
ireland$seasonWinter <- as.integer(ireland$season == "Winter")
ireland$seasonSpring <- as.integer(ireland$season == "Spring")
ireland$seasonSummer <- as.integer(ireland$season == "Summer")
ireland$seasonAutumn <- as.integer(ireland$season == "Autumn")

# Check the encoded variables
head(ireland)

#  Check the encoding results
table(ireland$day_encoded)
table(ireland$weekend)
table(ireland$season_encoded)

# Check that each row belongs to one season
table(
  ireland$seasonWinter +
    ireland$seasonSpring +
    ireland$seasonSummer +
    ireland$seasonAutumn
)

# Save the encoded dataset
write.csv(
  ireland,
  "data/ireland_electricity_encoded.csv",
  row.names = FALSE
)

