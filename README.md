# DataAnalytics-Assessment

This project contains SQL-based solutions for analyzing customer savings, investments, and behavioral metrics using structured queries across multiple relational tables.

---

## Overview

The assessment leverages three core tables:

- `users_customuser`: User profile data  
- `savings_savingsaccount`: Customer savings account information  
- `plans_plan`: Savings and investment plan definitions  

---

## Q1: High-Value Customers with Multiple Products

**Objective:** Identify customers who have both a regular savings and an investment fund.

**Approach:**
- Used `INNER JOIN` to connect users, accounts, and plans.
- Filtered users with both `is_regular_savings = 1` and `is_a_fund = 1` using a subquery and `HAVING`.
- Aggregated results using `COUNT` and `SUM` for savings/investment counts and total deposits.
- Applied `CASE` for conditional logic and `AS` for aliasing columns.

**Challenge:** Preventing duplicate rows and ensuring clean joins using consistent keys and aliases.

---

## Q2: Transaction Frequency Analysis

**Objective:** Categorize customers based on their monthly transaction frequency.

**Approach:**
- Extracted year and month using `EXTRACT()` for time-based grouping.
- Used `COUNT()` to calculate monthly transaction volume per customer.
- Calculated average monthly transactions per customer.
- Applied `CASE` to categorize frequency: High, Medium, or Low.
- Grouped and summarized by category.

**Challenge:** Ensuring mutually exclusive category logic and using appropriate date fields.

---

## Q3: Account Inactivity Alert

**Objective:** Flag accounts with no transactions in the last 365 days.

**Approach:**
- Used `DATEDIFF()` to calculate inactivity periods.
- Leveraged `MAX()` to find the most recent transaction per account.
- Separated queries for savings (`is_regular_savings = 1`) and investments (`is_a_fund = 1`).
- Combined results using `UNION`.
- Applied `LEFT JOIN` to ensure inclusion of inactive accounts.

**Challenge:** Assumes `confirmed_amount > 0` as activity indicator; may require business-specific validation.

---

## Q4: Customer Lifetime Value (CLV) Estimation

**Objective:** Estimate the lifetime value of each customer based on transaction history and tenure.

**Approach:**
- Joined user and account data via `owner_id`.
- Calculated:
  - `TENURE_MONTH` using `TIMESTAMPDIFF(MONTH, uc.date_joined, CURRENT_DATE)`
  - `TOTAL_TRANSACTIONS` per user
  - `ESTIMATED_CLV` with the formula:  
    ```
    (Total Transactions / Tenure Month) * 12 * (0.1% * Avg Transaction Amount)
    ```
- Used `CONCAT()` to format full names.

**Challenge:** Handling edge cases like zero-month tenure or users with minimal data.

---

##  Notes

- Queries are structured for readability and reuse.
- Proper aliasing and consistent formatting were applied throughout.

---
