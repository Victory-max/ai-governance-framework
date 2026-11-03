# Validation Checklist: Consumer Loan Approval Model (Tier 1)

Used by Model Risk Management for independent validation, per SR 11-7's three core elements: **conceptual soundness, ongoing monitoring and outcomes analysis.** Fair lending, explainability and AI-specific checks are added on top.

Rate each finding **High** (must fix before use), **Medium** (fix within 90 days) or **Low** (fix at next revalidation).

---

## A. Documentation and governance

- [ ] Model registered in the AI inventory with correct tier and named owner
- [ ] Purpose, intended use and limitations documented (see model card)
- [ ] Validator is independent: did not build or design the model
- [ ] Development documentation detailed enough that a qualified person could rebuild the model
- [ ] Approval authority matches tier (AI Governance Committee for Tier 1)

## B. Data

- [ ] Data sources listed, with lineage from source system to model input
- [ ] Data quality checked: missing values, outliers, duplicates, errors
- [ ] Training data covers the population the model will be used on (time period, products, geographies, applicant types)
- [ ] Known gaps documented, such as thin-file applicants or reject inference
- [ ] **No prohibited bases used as inputs** (race, color, religion, national origin, sex, marital status, age, receipt of public assistance, exercise of CCPA rights)
- [ ] Every input reviewed for **proxy risk**: correlation with protected traits estimated (for example using BISG for race/ethnicity), and the business reason for keeping it documented
- [ ] Data use permitted under FCRA permissible purpose and GLBA

## C. Conceptual soundness

- [ ] Choice of algorithm justified against simpler alternatives (for example logistic regression)
- [ ] Each input variable has a logical, documented link to credit risk
- [ ] Direction of each variable's effect makes sense (for example higher debt-to-income should not lower risk); monotonic constraints used where appropriate
- [ ] Target variable defined clearly (for example 90+ days past due within 18 months)
- [ ] Hyperparameter choices and tuning process documented
- [ ] Overfitting controls in place: separate train / validation / out-of-time test sets

## D. Performance and outcomes analysis

- [ ] Discrimination power measured on out-of-time data: AUC, Gini, KS
- [ ] Calibration checked: predicted default rates vs actual, by score band
- [ ] Performance compared to the current model or benchmark
- [ ] Stability checked across segments (product, channel, region, income band)
- [ ] Back-testing plan defined for after launch
- [ ] Sensitivity analysis: how outputs change when key inputs change

## E. Fair lending

- [ ] **Disparate treatment** review: no prohibited bases, no proxies used intentionally
- [ ] **Disparate impact** testing on approval rates by protected group:
  - Adverse impact ratio (AIR) per group. Ratios below 0.80 are a common screening flag for deeper review; this is a heuristic, not a legal threshold.
  - Statistical significance tested
  - Marginal effect of each variable on disparities measured
- [ ] **Less discriminatory alternative (LDA) search** performed and documented: other model versions with similar accuracy and smaller disparities considered
- [ ] Business justification documented for any remaining disparity
- [ ] Pricing and credit-limit outcomes tested as well, if the model affects them
- [ ] Results reviewed by Compliance / Fair Lending and Legal

## F. Explainability and adverse action

- [ ] Method chosen for explaining individual decisions (for example SHAP), and its limits documented
- [ ] Explanations tested for **accuracy and stability**: the same applicant gets the same reasons; reasons reflect what actually drove the decision
- [ ] Mapping from model features to plain-language **adverse action reason codes**
- [ ] Reasons are **specific**, as Regulation B requires (12 CFR 1002.9). Vague reasons like "internal standards" or "insufficient score" are not acceptable
- [ ] Notices include the principal reasons (Reg B commentary suggests no more than four)
- [ ] FCRA notice requirements met where credit report data contributed to the decision
- [ ] Sample of real adverse action notices reviewed by Compliance

## G. Robustness and security

- [ ] Behaviour tested on edge cases and missing or extreme inputs
- [ ] Protection against manipulated inputs (for example falsified income) considered
- [ ] Access to model, code and training data restricted and logged
- [ ] Model and data versions controlled; deployed version matches validated version

## H. Implementation

- [ ] Production scores match development scores on a test sample (parallel run)
- [ ] Input data pipelines tested end to end
- [ ] Underwriter override process defined, and overrides logged with reasons
- [ ] Fallback process defined if the model is unavailable

## I. Ongoing monitoring plan

| Metric | Frequency | Threshold / trigger |
|---|---|---|
| Population Stability Index (PSI) on score | Monthly | 0.10 investigate; 0.25 escalate |
| Characteristic stability (PSI per input) | Monthly | 0.25 escalate |
| AUC / KS on matured accounts | Quarterly | Drop of more than 5% from validation |
| Actual vs predicted default rate | Quarterly | Outside agreed tolerance band |
| Adverse impact ratio by group | Quarterly | Below 0.80 or meaningful decline |
| Underwriter override rate | Monthly | Above 10% or sharp change |
| Missing / invalid input rate | Monthly | Above 2% |

- [ ] Monitoring owner named and reports going to the AI Governance Committee
- [ ] Revalidation triggers defined: material change, threshold breaches, or 12 months

## J. Conclusion

| Item | Result |
|---|---|
| Overall rating | Approved / Approved with conditions / Not approved |
| High findings | |
| Medium findings | |
| Low findings | |
| Conditions of use | |
| Next revalidation date | |
| Validator / date | |
