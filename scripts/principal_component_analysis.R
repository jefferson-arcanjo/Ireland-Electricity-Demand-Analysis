
#  Load the cleaned dataset
ireland <- read.csv("data/ireland_electricity_clean.csv")

# Select the numerical variables for PCA
pca_data <- ireland[, c(
  "IE_load_actual_entsoe_transparency",
  "IE_load_forecast_entsoe_transparency",
  "IE_wind_onshore_generation_actual",
  "IE_temperature",
  "IE_radiation_direct_horizontal",
  "IE_radiation_diffuse_horizontal"
)]

#  Check the selected data
dim(pca_data)
summary(pca_data)

# Standardise the data and run PCA
pca_result <- prcomp(
  pca_data,
  center = TRUE,
  scale. = TRUE
)

# Check the PCA results
summary(pca_result)

# Check how the variables contribute to each component
round(pca_result$rotation, 3)


# Create a scree plot
plot(
  pca_result,
  type = "b",
  main = "PCA Scree Plot",
  ylim = c(0, 3)
)


#  Plot the first two principal components
plot(
  pca_result$x[, 1],
  pca_result$x[, 2],
  main = "First Two Principal Components",
  xlab = "PC1 (39.13% Variance)",
  ylab = "PC2 (30.17% Variance)",
  col = "steelblue",
  pch = 16,
  cex = 0.3
)

# Calculate the explained variance
explained_variance <- pca_result$sdev^2 /
  sum(pca_result$sdev^2) * 100

round(explained_variance, 2)

# Calculate cumulative explained variance
round(cumsum(explained_variance), 2)

#  Check how many components explain at least 80% of variance
which(cumsum(explained_variance) >= 80)[1]
