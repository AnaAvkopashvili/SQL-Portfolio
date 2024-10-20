# SQL-Portfolio
SQL Portfolio Projects
This repository contains SQL projects that demonstrate my data exploration, manipulation, and visualization skills. The main projects included are:

1. COVID-19 Data Exploration and Visualization
Overview: 
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
Overview: 
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


3. NYC Taxi Trips & Weather Data Analysis
Overview: 
This project showcases various SQL queries and analyses performed on a dataset containing NYC taxi trips and corresponding weather data. The goal is to demonstrate SQL skills and analyzing the impact of external factors (like weather) on taxi fare amounts.

Key Queries and Insights:
- Total Trips and Fare Analysis by Payment Type:
- Yearly Trends in Taxi Trips:
- Impact of Weather Conditions on Fare Amounts:
- Analyzed how weather conditions impact the tipping behavior of passengers.
  
Skills Demonstrated:
- Data Aggregation and Filtering
- Date and Time Functions
- Table Joins and Relationships
- Subqueries and Common Table Expressions (CTEs)
  
Additional Experience:
- This project was developed using Dremio, a data lakehouse platform, allowing the exploration of new capabilities and insights unique to this cutting-edge technology. Working with Dremio provided valuable experience in handling large-scale data and utilizing advanced features of a modern data lakehouse.



4.Fraud Detection Dashboard and SQL Queries

Overview:
This project focuses on detecting financial fraud using various SQL queries on a fraud detection dataset. The queries analyze patterns in customer transactions, transaction types, amounts, and fraud timing, offering insights into fraudulent behavior. Additionally, Benford's Law is applied to detect anomalies in transaction amounts.

Queries Breakdown:
- Top Flagged Customers by Transaction Amount
  This query identifies the top 10 customers with the highest total transaction amounts, helping to flag high-risk individuals for further investigation.

- Fraud by Transaction Type
  This query analyzes fraudulent transactions based on their type (e.g., CASH_OUT, PAYMENT), providing insights into which transaction types are more prone to fraud.

- Fraud Detection Based on Transaction Amount
  This query investigates the relationship between transaction amounts and fraud, identifying specific amounts that are most frequently associated with fraudulent behavior.

- Average Transaction Amount (Fraudulent vs. Non-Fraudulent)
  This query calculates and compares the average transaction amounts for both fraudulent and non-fraudulent transactions, highlighting key differences.

- Fraud Count by Hour of Day
  This query examines the frequency of fraudulent transactions across different hours of the day, allowing for the identification of time-based fraud patterns.

- Benford's Law for Fraud Detection
  Benford's Law is applied to the leading digits of transaction amounts for fraudulent transactions, helping to detect suspicious patterns that deviate from expected norms.

