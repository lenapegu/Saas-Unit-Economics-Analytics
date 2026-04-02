# Saas-Subsription-Model-Unit-Economics-Analytics
Interactive Tableau dashboard & SQL analysis for SaaS unit economics - Сase Study

**View Tableau Dashboard**: https://public.tableau.com/shared/MCXMBS295?:display_count=n&:origin=viz_share_link

## Objective
The goal of this project is to build a analytics pipeline for a SaaS platform to evaluate business health, identify high-value subsription plans and optimize marketing budget allocation.

### Key Business Questions:
* Is the business model sustainable based on Unit Economics?
* What are the MRR growth trends and customer retention patterns?
* How should the marketing budget be reallocated to maximize ROI?

---

## Methodology & Tech Stack
### 1. Data Layer (Raw Data)
The analysis is based on three relational datasets:
* `customers.csv`: User profiles, plan types, and churn dates.
* `subscriptions.csv`: Historical activity records.
* `revenue.csv`: Transactional details (MRR and one-time payments).

### 2. Transformation Layer (SQL)
Using **PostgreSQL**, I transformed raw data into Tableau views:
* `v_monthly_dashboard`: Aggregates monthly metrics (Total MRR, Active Users, New Customers, Churn Rate).
* `v_unit_economics_dashboard`: Calculates unit-level performance (CAC, LTV, Payback Period, LTV/CAC Ratio).
* `v_cohort_retention`: Generates a matrix for Cohort Analysis.

### 3. Visualization Layer (Tableau)
Developed an interactive dashboard:
* Strategic KPI Factoids: Summary cards for MRR, Active Customers, New Users, and Churn Rate to show 12-month performance trends.
* Revenue Dynamics: An Area Chart showing MRR growth over time
* Unit Economics Deep-Dive: An analysis of LTV/CAC and Payback Period segmented by subscription plans (Basic, Pro, Enterprise).
* Retention Analysis: Monthly Churn Rate trends combined with Customer Acquisition metrics to monitor business health.

---

## 4. Key Findings
* **Marketing Hyper-Efficiency:** The average **LTV/CAC ratio is 13.5x**, significantly exceeding the 3x industry benchmark.
* Enterprise as a Growth Engine:** The Enterprise segment is the top performer with a **14.6x ratio** and an ultra-fast **Payback Period of 0.4 months**
* **Retention Vulnerability:** Cohort analysis identifies a critical drop-off point at month 6 (Average Lifetime: 5.9 months)
* **Revenue Correlation:** MRR growth is outpacing user base growth, indicating successful upselling to Pro and Enterprise plans

---

## 5.Strategic Recommendations
1. Current metrics (Payback < 1 month) suggest under-investment. **Recommendation:** Increase Enterprise acquisition budget by 100%. 
2. The Basic plan shows the lowest efficiency (9.2x). **Recommendation:** Shift Basic to acquisition and reallocate its paid budget to higher-margin tiers
3. Implement CRM automation targeting users in their **5th month** (just before the average 6-month drop-off)


---

## Conclusion
This project demonstrates a full-cycle analytical approach: from processing raw transactional data to defining a data-driven growth strategy. The final Tableau dashboard serves as a decision-making tool for leadership, highlighting the most profitable areas for business scaling.
