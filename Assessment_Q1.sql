select 
uc.id as owner_id,
concat(uc.first_name, ' ', uc.last_name) AS name,
count(pp.is_regular_savings) As savings_count,
count(pp.is_a_fund) AS investment_count,
sum(sa.confirmed_amount) AS total_deposit
from  
adashi_staging.users_customuser AS uc
inner join
adashi_staging.savings_savingsaccount AS sa on uc.id = sa.owner_id
inner join
adashi_staging.plans_plan AS pp on sa.plan_id = pp.id
where
uc.id in 
(
select sa.owner_id from adashi_staging.savings_savingsaccount AS sa
inner join
adashi_staging.plans_plan AS pp on sa.plan_id = pp.id
group by
sa.owner_id
having 
sum(case when pp.is_regular_savings = 1 then 1 else 0 end) >=1
and sum(case when pp.is_a_fund = 1 then 1 else 0 end) >=1
)
group by 
uc.id, pp.is_a_fund, pp.is_regular_savings
order by
total_deposit;