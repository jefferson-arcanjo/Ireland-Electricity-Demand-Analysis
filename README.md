# Ireland Electricity Demand Analysis

## Project Overview

This project was completed for the Data Exploration and Preparation (CA1) module at CCT College Dublin.

The aim is to analyse electricity demand in Ireland between 2015 and 2019 and explore how it relates to weather conditions and wind energy generation.

The analysis was completed using RStudio.

## Datasets

The datasets used in this project were obtained from Open Power System Data (OPSD).

Electricity Dataset: time_series_60min_singleindex.csv

https://data.open-power-system-data.org/time_series/2020-10-06/

Weather Dataset: weather_data.csv

https://data.open-power-system-data.org/weather_data/2020-09-16/

Both datasets were used to analyse electricity demand, wind generation and weather conditions in Ireland between 2015 and 2019.

## Data Preparation

The datasets were merged using their timestamps, and only Irish data was selected.

The merged dataset contained 43,825 rows. After removing 608 incomplete rows, the final cleaned dataset contained **43,217 rows and 7 columns**, with no missing values or duplicate timestamps.

## Analysis

The project includes:

- Exploratory Data Analysis (EDA) and visualisations.
- Electricity demand patterns by hour, day, month and season.
- Correlation analysis between electricity demand, weather and wind generation.
- Categorical encoding.
- Principal Component Analysis (PCA).

## Key Findings

- Electricity demand increased by approximately 9.4% between 2015 and 2019.
- Demand was generally higher during winter and on weekdays.
- Actual and forecast electricity demand had a strong correlation (0.956).
- Temperature had a very weak negative correlation with electricity demand (-0.060).
- The first three principal components explained 83.95% of the total variance.

## Tools Used

- R and RStudio
- Git and GitHub
- Open Power System Data (OPSD)

## Conclusion

This project helped me improve my skills in data cleaning, exploration and visualisation using R. I also learned how to apply categorical encoding and PCA to analyse real-world data.