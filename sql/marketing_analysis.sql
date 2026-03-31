-- 1. DATA VALIDATION 

-- Check for NULL values in critical subscription fields
SELECT *
FROM customer_month_metrics
WHERE customer_id IS NULL 
   OR mrr IS NULL 
   OR month IS NULL;



-- 2. MONTHLY PERFORMANCE METRICS (MRR & Customer Growth)


-- Creating a View for Monthly Executive Dashboard
-- Metrics: Active Customers, Total MRR, ARPU, New & Churned Customers
CREATE VIEW v_monthly_dashboard AS
SELECT 
    month,
    plan_type,
    COUNT(DISTINCT customer_id) AS active_customers,
    SUM(mrr) AS total_mrr,
    ROUND(AVG(mrr), 2) AS arpu,
    -- Calculate New Customers based on signup month
    SUM(CASE 
        WHEN signup_date >= TO_DATE(month || '-01', 'YYYY-MM-DD') 
        AND signup_date < (TO_DATE(month || '-01', 'YYYY-MM-DD') + INTERVAL '1 month') 
        THEN 1 ELSE 0 
    END) AS new_customers,
    -- Calculate Churned Customers based on churn month
    SUM(CASE 
        WHEN churn_date >= TO_DATE(month || '-01', 'YYYY-MM-DD') 
        AND churn_date < (TO_DATE(month || '-01', 'YYYY-MM-DD') + INTERVAL '1 month') 
        THEN 1 ELSE 0 
    END) AS churned_customers
FROM customer_month_metrics
GROUP BY month, plan_type;



-- 3. UNIT ECONOMICS

-- Creating a View for Unit Economics tracking
-- Metrics: LTV (Total Revenue), CAC, LTV/CAC Ratio, and Payback Period
CREATE VIEW v_unit_economics_dashboard AS
SELECT 
    customer_id,
    plan_type,
    cac,
    total_revenue AS ltv,
    lifetime_months,
    avg_mrr,
    ltv_cac_ratio,
    payback_months
FROM customer_unit_economics;



-- 4. COHORT ANALYSIS (Retention Calculation)


-- Creating a View for Cohort Analysis 
-- Goal: Calculate the month number in the customer lifecycle (Month 0, 1, 2...)
CREATE VIEW v_cohort_retention AS
SELECT 
    customer_id,
    plan_type,
    DATE_TRUNC('month', signup_date)::DATE AS cohort_month,
    month AS activity_month,
    -- Calculating the difference in months between activity and signup
    EXTRACT(YEAR FROM AGE(TO_DATE(month || '-01', 'YYYY-MM-DD'), DATE_TRUNC('month', signup_date))) * 12 + 
    EXTRACT(MONTH FROM AGE(TO_DATE(month || '-01', 'YYYY-MM-DD'), DATE_TRUNC('month', signup_date))) AS month_number
FROM customer_month_metrics;
