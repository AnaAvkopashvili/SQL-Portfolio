SELECT * FROM reporting."nyc_trips_weather";

-- 1. Query: Find the total number of trips and the average fare amount for each payment type.

SELECT 
    payment_type,
    COUNT(*) as total_trips_by_payment_type,
    AVG(fare_amount) as average_fare_by_payment_type
FROM reporting."nyc_trips_weather"
GROUP BY payment_type;

-- 2. Query: Extract the year and find the total number of trips for each year.

SELECT 
    YEAR(pickup_datetime) as pickup_year,
    COUNT(*) as total_tips_by_months
FROM reporting."nyc_trips_weather"
GROUP BY YEAR(pickup_datetime);


-- 3. Query: Join trip data with weather data based on the date to analyze how weather conditions impact fare amount.

SELECT t.pickup_datetime, t.fare_amount, w.tempmax, w.tempmin, w.prcp
FROM semantic.nyc_trips t
JOIN semantic.nyc_weather w
ON t.pickup_date = w."date";


-- 4. Query: List all trips that have a fare amount greater than the average fare.

SELECT *
FROM reporting."nyc_trips_weather"
WHERE fare_amount > 
(
    SELECT AVG(fare_amount) as avg_fare
    FROM reporting."nyc_trips_weather"
);


-- 5. Query: Calculate the average fare per payment type, and then use it to filter trips with fare amounts above the average.

WITH avg_per_payment_type AS
(
    SELECT  payment_type, AVG(fare_amount) as avg_fare
    FROM reporting."nyc_trips_weather"
    GROUP BY payment_type
)
SELECT * 
FROM reporting."nyc_trips_weather" as original
JOIN avg_per_payment_type as cte
ON cte.payment_type = original.payment_type
WHERE original.fare_amount > cte.avg_fare;


-- 6. Query: Analyze the effect of weather conditions on tip amounts by joining the trip data with weather data and grouping by weather conditions.

SELECT w.tempmax, w.tempmin, w.prcp, AVG(t.tip_amount) AS AverageTipAmount
FROM semantic.nyc_trips AS t
JOIN semantic.nyc_weather AS w 
ON t.pickup_date = w."date" 
GROUP BY w.tempmax, w.tempmin, w.prcp;












