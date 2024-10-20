-- FRAUD DETECTION PATTERNS	

--Top 10  flagged Customers with most transaction amounts
SELECT TOP 10 nameOrig, SUM(amount) AS total_transactions
FROM FraudDatabase
GROUP BY nameOrig
ORDER BY total_transactions DESC;


-- Fraud by Transaction Type
SELECT type, COUNT(*) AS fraud_count
FROM FraudDatabase
WHERE isFraud = 1
GROUP BY type;


-- Fraud Detection Based on Transaction Amount
SELECT amount, COUNT(*) AS fraud_count
FROM FraudDatabase
WHERE isFraud = 1
GROUP BY amount
ORDER BY amount DESC;


-- Average transaction amount for fraudulent and non-fraudulent transactions
SELECT isFraud, AVG(amount) AS avg_amount
FROM FraudDatabase
GROUP BY isFraud;


-- Froud Count By Hours
SELECT step % 24 AS hour_of_day, COUNT(*) AS fraud_count
FROM FraudDatabase
WHERE isFraud = 1
GROUP BY step % 24
ORDER BY fraud_count;


-- Benfard's law for fraudulent transactions
SELECT 
    LEFT(CAST(amount AS VARCHAR), 1) AS leading_digit, 
    COUNT(*) AS frequency
FROM 
    FraudDatabase
WHERE 
    amount > 0 AND isFraud = 1  
GROUP BY 
    LEFT(CAST(amount AS VARCHAR), 1)
ORDER BY 
    leading_digit;
