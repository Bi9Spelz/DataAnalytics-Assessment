SELECT 
  pp.id AS Plan_id,
  pp.owner_id AS Owner_id,
  'investment' AS Type,
  MAX(sa.transaction_date) AS Last_transaction_date,
  DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) AS Inactivity_days
FROM 
  adashi_staging.plans_plan AS pp
  LEFT JOIN adashi_staging.savings_savingsaccount AS sa ON pp.id = sa.plan_id
WHERE 
  (pp.is_a_fund = 1 AND sa.confirmed_amount > 0)
GROUP BY 
  pp.id
  HAVING
  DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) >= 365
  
UNION ALL

SELECT 
  sa.plan_id AS Plan_id,
  sa.owner_id,
  'savings' AS Type,
  MAX(sa.transaction_date) AS Last_transaction_date,
  DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) AS Inactivity_days
FROM 
  adashi_staging.savings_savingsaccount AS sa
  LEFT JOIN adashi_staging.plans_plan AS pp ON sa.plan_id = pp.id
WHERE 
  (pp.is_regular_savings = 1 AND sa.confirmed_amount > 0 )
GROUP BY 
  sa.id
  HAVING
  DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) >=365