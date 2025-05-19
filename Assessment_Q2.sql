WITH monthly_transactions AS (
  SELECT 
    EXTRACT(YEAR FROM sa.transaction_date) AS year,
    EXTRACT(MONTH FROM sa.transaction_date) AS month,
    sa.owner_id AS customer_id,
    COUNT(sa.id) AS customer_count
  FROM 
    adashi_staging.savings_savingsaccount AS sa
  GROUP BY 
    EXTRACT(YEAR FROM sa.transaction_date),
    EXTRACT(MONTH FROM sa.transaction_date),
    sa.owner_id
),
avg_monthly_transactions AS (
  SELECT 
    customer_id,
    AVG(customer_count) AS avg_transactions
  FROM 
    monthly_transactions
  GROUP BY 
    customer_id
)
SELECT 
  CASE 
    WHEN avg_transactions >= 10 THEN 'High Frequency'
    WHEN avg_transactions BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END AS frequency_category,
  COUNT(customer_id) AS customer_count,
  AVG(avg_transactions) AS avg_transaction_per_month
FROM 
  avg_monthly_transactions
GROUP BY
  CASE 
    WHEN avg_transactions >= 10 THEN 'High Frequency'
    WHEN avg_transactions BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END
ORDER BY 
  avg_transaction_per_month DESC;
