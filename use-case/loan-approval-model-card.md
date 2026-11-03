# Model Card: Consumer Loan Approval Model

**Sample Community Bank (fictional)** · Inventory ID: `AI-0001` · Risk tier: **Tier 1 (High)**

## 1. Overview

| Field | Value |
|---|---|
| Model name | Consumer Unsecured Loan Approval Model v2.0 |
| Model owner | Head of Consumer Lending |
| Developer | Credit Risk Analytics team (in-house) |
| Validator | Model Risk Management |
| Approval body | AI Governance Committee |
| Status | In validation |
| Products | Unsecured personal loans, $1,000 – $35,000 |

## 2. Intended use

- **Does:** Estimates the probability that an applicant will become 90+ days past due within 18 months, and recommends Approve, Refer or Decline.
- **Decision flow:**
  - Low-risk scores → recommended Approve; underwriter confirms.
  - Middle band → Refer to an underwriter for full review.
  - High-risk scores → recommended Decline; an underwriter reviews before any adverse action notice is sent.
- **Does not:** Set interest rates or credit limits, or assess mortgage, auto, or small business loans.

## 3. Out-of-scope uses

Using this model for any other product, for marketing, for collections, or for employment decisions is not permitted without a new approval.

## 4. Data

| Item | Detail |
|---|---|
| Training period | Applications from Jan 2021 – Dec 2023, performance observed to mid-2025 |
| Sample size | About 48,000 booked loans (illustrative) |
| Sources | Credit bureau report, application form, internal deposit account history (with consent) |
| Excluded | All prohibited bases; ZIP code; first name; email domain; device type |

### Input variables (illustrative)

| Variable | Business reason |
|---|---|
| Debt-to-income ratio | Ability to repay |
| Credit utilization | Current credit stress |
| Months since most recent delinquency | Recent repayment behaviour |
| Number of recent credit inquiries | Recent credit seeking |
| Length of credit history | Track record |
| Verified monthly income | Ability to repay |
| Average deposit balance (existing customers) | Cash-flow strength |

## 5. Method

- Gradient-boosted decision trees with **monotonic constraints** (for example, higher debt-to-income can only raise predicted risk).
- Benchmarked against a logistic regression scorecard.
- Individual explanations using SHAP values, mapped to adverse action reason codes.

## 6. Performance (illustrative)

| Metric | New model | Current scorecard |
|---|---|---|
| AUC (out-of-time) | 0.78 | 0.73 |
| KS | 0.42 | 0.36 |

## 7. Fairness testing summary (illustrative)

Protected-group membership estimated with BISG (for race/ethnicity) for testing only. These estimates are never used as model inputs.

| Group comparison | Adverse impact ratio (approval rate) | Status |
|---|---|---|
| Black vs White applicants | 0.86 | Above 0.80 screen; monitor |
| Hispanic vs non-Hispanic White applicants | 0.91 | Above 0.80 screen |
| Female vs Male applicants | 0.97 | Above 0.80 screen |
| Applicants 62+ vs under 62 | 1.02 | No concern |

**Less discriminatory alternative search:** 12 model versions tested. The selected version reduced the Black/White gap compared with the first draft (0.81 → 0.86) with less than 0.5 point loss in AUC.

## 8. Adverse action reason codes (sample)

| Main model driver | Reason given to applicant |
|---|---|
| High debt-to-income ratio | Debt obligations too high relative to income |
| Recent delinquency | Recent delinquency on one or more accounts |
| High credit utilization | Proportion of balances to credit limits too high |
| Short credit history | Length of credit history insufficient |
| Many recent inquiries | Too many recent requests for credit |

## 9. Limitations and known risks

- Less accurate for applicants with thin credit files; these are routed to Refer.
- Trained mostly during a period of low unemployment; may perform worse in a downturn.
- SHAP explanations approximate the model's reasoning and must be checked for stability.

## 10. Monitoring

Monthly PSI and override reports; quarterly performance and fairness reports to the AI Governance Committee. See [validation checklist, section I](../validation/loan-model-validation-checklist.md#i-ongoing-monitoring-plan).

## 11. Change log

| Version | Date | Change |
|---|---|---|
| 1.0 | 2022 | Logistic regression scorecard |
| 2.0 | 2026 | Gradient-boosted model with monotonic constraints and SHAP reason codes |
