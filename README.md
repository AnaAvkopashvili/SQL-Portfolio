# SQL-Portfolio
SQL Portfolio Projects
This repository contains SQL projects that demonstrate my data exploration, manipulation, and visualization skills. The two main projects included are:

1. COVID-19 Data Exploration and Visualization
Overview
This project explores global COVID-19 data, focusing on the impact of the pandemic across different continents and countries. The data is analyzed to identify trends in infection rates, death rates, and vaccination progress. A Tableau dashboard was created using the insights derived from SQL queries.

Key Queries and Insights:
- Global Impact Analysis: Summed up the total number of cases and deaths worldwide, calculating the global death percentage.
- Continent-wise Death Count: Identified the continents with the highest death toll.
- Infection Rate Analysis: Found countries with the highest infection rates by calculating the percentage of the population affected.
- Vaccination Progress: Analyzed the progress of COVID-19 vaccinations by calculating running totals and comparing them to population sizes.
Skills Demonstrated:
- Data aggregation using SUM and MAX.
- Joining multiple datasets to combine COVID-19 case data with vaccination data.
- Window functions for calculating running totals.
- Common Table Expressions (CTEs) for organizing complex queries.
2. Nashville Housing Data Cleaning
Overview
This project involves cleaning and transforming Nashville housing data. The dataset contains property sales data that required standardization and normalization to make it suitable for analysis.

Key Cleaning Steps:
- Standardizing Date Formats: Converted sale dates to a consistent date format.
- Populating Missing Addresses: Filled in missing property addresses based on unique Parcel IDs.
- Splitting Addresses: Separated property addresses into individual components (street, city, state).
- Removing Duplicates: Identified and removed duplicate records based on key columns.
- Dropping Unused Columns: Cleaned up the dataset by removing columns that were no longer necessary.
Skills Demonstrated:
- Use of ROW_NUMBER() for identifying duplicates.
- String manipulation using SUBSTRING and PARSENAME.
- Data type conversions and updates.
- Efficient use of CTEs for organizing query logic.
These projects showcase my ability to handle real-world data challenges, from cleaning and preparing data to performing complex analyses and creating visualizations.

Feel free to explore the SQL scripts provided in this repository, and let me know if you have any questions or feedback.

