# SaaS Subscription Unit Economics & Retention Analysis — Case Study

Interactive Tableau dashboard and SQL analysis of unit economics and retention for a SaaS subscription business.

**View Tableau Dashboard:** https://public.tableau.com/shared/MCXMBS295?:display_count=n&:origin=viz_share_link

## Objective

This project builds an analytics pipeline to evaluate business health, identify high-value subscription plans, and guide marketing budget allocation.

Key business questions:
- Is the business model sustainable based on unit economics?
- What are the MRR growth trends and customer retention patterns?
- How should marketing budget be reallocated to maximize ROI?

## Methodology & Tech Stack

**1. Data Layer (Raw Data)**

Three relational datasets:
- `customers.csv` — user profiles, plan types, and churn dates
- `subscriptions.csv` — historical activity records
- `revenue.csv` — transactional details (MRR and one-time payments)

**2. Transformation Layer (SQL)**

PostgreSQL transforms the raw data into three Tableau-ready views:
- `v_monthly_dashboard` — aggregates monthly metrics (total MRR, active users, new customers, churn rate)
- `v_unit_economics_dashboard` — calculates unit-level performance (CAC, LTV, payback period, LTV/CAC ratio)
- `v_cohort_retention` — generates a matrix for cohort analysis

**3. Visualization Layer (Tableau)**

An interactive dashboard with:
- Strategic KPI cards for MRR, active customers, new users, and churn rate
- Revenue dynamics: an area chart of MRR growth by plan type over time
- Unit economics deep-dive: LTV/CAC and payback period by plan (Basic, Pro, Enterprise)
- Retention analysis: a cohort retention heatmap and monthly churn rate trend

## Data & Methodology Notes

This is a fictional case study built on synthetic data. During QA, I found and fixed two data quality issues before finalizing the analysis. I document them here because catching them mattered as much as the final numbers.

**Right-censoring in the churn calculation.** The original logic marked any customer whose last recorded activity fell in the dataset's final month as "churned" — even customers who were simply still active when data collection stopped. This produced an artificial 100% churn spike in the final month. Fix: I trimmed the censored boundary month from the cohort and monthly datasets, so only customers with a confirmed end to their lifecycle count as churned.

**Unrealistic CAC assumptions.** Initial CAC figures ($30–$200 flat per plan) produced LTV/CAC ratios of 9x–14.6x and payback periods under a month — implausible for any SaaS business, and especially for Enterprise, which typically carries a far higher sales-led acquisition cost. I recalibrated CAC to match each plan's go-to-market motion (self-serve vs. sales-assisted) and recalculated every dependent metric.

## Key Findings

**1. Unit economics are healthy but uneven across plans**

| Plan | LTV/CAC | Payback Period | Avg. Monthly Churn |
|---|---|---|---|
| Enterprise | 3.3x | 1.8 months | 8.5% |
| Pro | 2.8x | 2.3 months | 7.3% |
| Basic | 1.9x | 3.0 months | 7.1% |

Enterprise clears the 3x LTV/CAC benchmark; Pro comes close. Basic falls well short — it returns the least per acquisition dollar.

**2. Churn accelerated sharply in Q1–Q2 2025**

Monthly churn held steady at 5–7% through January and February 2025, then climbed to 20–23% by March–May — a 3–4x jump in three months. This deserves more urgency than any LTV/CAC ratio. Find the cause — a pricing change, a product issue, a seasonal cohort effect — before scaling acquisition spend.

**3. Enterprise retention matches Basic and Pro, despite a 10x price premium**

Average customer lifetime sits near 6 months across all three plans — Basic 5.7, Pro 6.3, Enterprise 6.0. Enterprise charges 10x more than Basic but keeps customers no longer. That caps Enterprise's LTV upside and deserves attention from whoever owns enterprise customer success.

**4. Acquisition mix, not upsell, drives revenue growth**

MRR has grown faster than the active-user base, but new customers explain it — they increasingly choose Pro or Enterprise at signup. Not one customer in the dataset moved between plan tiers after joining. The original framing called this "successful upselling." The data doesn't support that claim, so I corrected it.

## Strategic Recommendations

1. **Reallocate Basic's acquisition budget.** At 1.9x LTV/CAC, Basic spend is the least efficient dollar in the budget. Move it to Pro and Enterprise, where the ratio clears or nears 3x.
2. **Find the cause of the Q1 2025 churn spike before scaling spend.** A 3–4x jump in monthly churn calls for root-cause analysis — pricing, onboarding, a feature change — before any budget increase. Scaling acquisition into an unexplained churn spike only compounds the problem.
3. **Build a retention play around month 4–5.** Cohort data shows the steepest drop-off starting around month 5–6. Proactive CRM outreach just before that window is the single best retention move available.
4. **Revisit Enterprise's retention strategy.** Enterprise lifetime doesn't outpace Basic despite the premium price — a dedicated customer-success motion for this segment would protect the highest revenue-per-customer tier.

## Conclusion

This project covers the full analytics cycle: building SQL transformation logic, catching and fixing data quality issues — right-censoring, unrealistic input assumptions — before trusting the output, then turning corrected metrics into prioritized recommendations. The dashboard answers three questions: where to grow, where to pull back, and what to investigate next.
