SELECT 
  uc.id AS Customer_id,
  concat(uc.first_name,' ', uc.last_name)AS Name,
  TIMESTAMPDIFF(MONTH, uc.date_joined, CURRENT_DATE) AS Tenure_months,
  COUNT(sa.id) AS Total_transactions,
  (COUNT(sa.id) / TIMESTAMPDIFF(MONTH, uc.date_joined, CURRENT_DATE)) * 12 * (0.1/100 * AVG(sa.confirmed_amount)) AS Estimated_CLV
FROM 
  adashi_staging.users_customuser AS uc
  JOIN adashi_staging.savings_savingsaccount AS sa ON uc.id = sa.owner_id
GROUP BY 
  uc.id, uc.name, uc.date_joined
ORDER BY 
  Estimated_CLV DESC;