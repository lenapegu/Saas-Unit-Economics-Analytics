
# SaaS Subscription Unit Economics & Retention Analysis — Case Study

Interactive Tableau dashboard & SQL analysis evaluating the financial health and retention dynamics of a SaaS subscription business.

**View Tableau Dashboard:** https://public.tableau.com/shared/MCXMBS295?:display_count=n&:origin=viz_share_link

## Objective

The goal of this project is to build an analytics pipeline for a SaaS platform to evaluate business health, identify high-value subscription plans, and guide marketing budget allocation.

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

Using PostgreSQL, raw data is transformed into three Tableau-ready views:
- `v_monthly_dashboard` — aggregates monthly metrics (total MRR, active users, new customers, churn rate)
- `v_unit_economics_dashboard` — calculates unit-level performance (CAC, LTV, payback period, LTV/CAC ratio)
- `v_cohort_retention` — generates a matrix for cohort analysis

**3. Visualization Layer (Tableau)**

An interactive dashboard with:
- Strategic KPI cards summarizing MRR, active customers, new users, and churn rate
- Revenue dynamics: an area chart of MRR growth by plan type over time
- Unit economics deep-dive: LTV/CAC and payback period segmented by plan (Basic, Pro, Enterprise)
- Retention analysis: cohort retention heatmap and monthly churn rate trend

## Data & Methodology Notes

This is a fictional case study built on synthetic data for portfolio purposes. During QA, two data quality issues were identified and corrected before finalizing the analysis — documenting them here because catching them was part of the analytical process:

**Right-censoring in churn calculation.** The original churn logic counted any customer whose last recorded activity fell on the dataset's final calendar month as "churned" — including customers who were simply still active when data collection stopped. This produced an artificial 100% churn spike in the last month. Fix: the censored boundary month was trimmed from the cohort and monthly datasets so that only customers with a confirmed lifecycle end are counted as churned.

**Unrealistic CAC assumptions.** Initial CAC figures ($30–$200 flat per plan) produced LTV/CAC ratios of 9x–14.6x and sub-1-month payback periods — well outside plausible SaaS benchmarks, particularly for the Enterprise tier, which typically carries a much higher sales-led acquisition cost. CAC assumptions were recalibrated to figures consistent with each plan's go-to-market motion (self-serve vs. sales-assisted), and all dependent metrics (LTV/CAC, payback) were recalculated accordingly.

## Key Findings

**1. Unit economics are healthy but uneven across plans**

| Plan | LTV/CAC | Payback Period | Avg. Monthly Churn |
|---|---|---|---|
| Enterprise | 3.3x | 1.8 months | 8.5% |
| Pro | 2.8x | 2.3 months | 7.3% |
| Basic | 1.9x | 3.0 months | 7.1% |

Enterprise and Pro clear the 3x LTV/CAC industry benchmark or come close to it; Basic sits meaningfully below it, signaling the weakest return on acquisition spend.

**2. Churn accelerated sharply in Q1–Q2 2025**

Overall monthly churn held steady at 5–7% through January–February 2025, then climbed to 20–23% by March–May 2025 — a 3–4x jump in a short window. This is a more urgent signal than any single LTV/CAC ratio and should be investigated (pricing change, product issue, or seasonal cohort effect) before any acquisition budget is scaled up.

**3. Enterprise customers don't retain meaningfully longer than other tiers**

Average observed customer lifetime is close to 6 months across all three plans (Basic 5.7, Pro 6.3, Enterprise 6.0). Despite charging a 10x premium over Basic, Enterprise customers aren't staying proportionally longer — this caps Enterprise LTV upside and is worth flagging to whoever owns enterprise customer success.

**4. Revenue growth is driven by acquisition mix, not upsell**

MRR growth has outpaced active-user growth, but this is fully explained by new customers increasingly choosing Pro/Enterprise at signup — no customer in the dataset moved between plan tiers after acquisition. The original framing of this as "successful upselling" wasn't supported by the data and has been corrected here.

## Strategic Recommendations

1. **Reallocate Basic's paid acquisition budget.** With LTV/CAC at 1.9x, Basic acquisition spend is the least efficient dollar in the budget. Shift it toward Pro/Enterprise acquisition, where the ratio clears or nears the 3x benchmark.
2. **Investigate the Q1 2025 churn spike before scaling spend.** A 3–4x increase in monthly churn deserves root-cause analysis (pricing, onboarding, a specific feature change) ahead of any budget increase — growing acquisition into an unexplained churn spike compounds the problem.
3. **Build a retention play around month 4–5.** Cohort data shows the steepest drop-off beginning around month 5–6 of the customer lifecycle; proactive CRM outreach just before that window is the highest-leverage retention lever available.
4. **Revisit Enterprise's value proposition for long-term retention.** Since Enterprise lifetime isn't outpacing Basic despite premium pricing, a dedicated customer-success motion for this segment would protect the highest revenue-per-customer tier.

## Conclusion

This project demonstrates a full analytics cycle: building SQL transformation logic, catching and correcting data quality issues (right-censoring, unrealistic input assumptions) before trusting the output, and translating corrected metrics into prioritized, defensible recommendations. The dashboard serves as a decision-making reference for where to grow, where to pull back, and what to investigate next.
