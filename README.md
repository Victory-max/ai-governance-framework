# AI Governance Framework for a US Community Bank

A sample, end-to-end framework for governing AI at a US bank, built around one high-risk use case: **an AI model that recommends approve/decline decisions on consumer loan applications.**

> **Fictional example.** "Sample Community Bank" is invented. This is a portfolio and learning project, not legal advice. A real bank would adapt it with its own legal, compliance and model risk teams.

## Why this project

US banks don't have a single AI law. AI is governed through existing rules:

- **SR 11-7 / OCC 2011-12** — model risk management. Examiners treat most AI as a "model."
- **ECOA / Regulation B** and the **Fair Housing Act** — no discrimination, and specific reasons when credit is denied.
- **FCRA** — rules on credit data and customer notices.
- **Interagency Third-Party Risk Guidance (2023)** — AI bought from vendors.
- **NIST AI RMF 1.0** — a voluntary structure (Govern, Map, Measure, Manage) used to organize the program.

A loan approval model touches all of them, which makes it a good test case.

## What's inside

| Folder | Contents |
|---|---|
| [`policy/`](policy/ai-governance-policy.md) | The bank's AI governance policy: scope, roles, committee, lifecycle, prohibited uses |
| [`risk/`](risk/risk-tiering-matrix.md) | Risk-tiering matrix that decides how much oversight each AI system gets |
| [`inventory/`](inventory/ai_inventory_schema.sql) | MySQL schema for the AI inventory, with sample data and reporting queries |
| [`validation/`](validation/loan-model-validation-checklist.md) | Validation checklist for the loan model: conceptual soundness, fairness, explainability, monitoring |
| [`compliance/`](compliance/regulatory-mapping.md) | Mapping of each regulation to the framework control that covers it |
| [`use-case/`](use-case/loan-approval-model-card.md) | Model card for the loan approval model |

## How the pieces fit

1. A business line proposes an AI system and registers it in the **inventory**.
2. The **risk-tiering matrix** assigns a tier. The loan model is **Tier 1 (High)**.
3. The **policy** sets the controls each tier requires.
4. Independent validators use the **validation checklist** before approval and on a schedule afterward.
5. The **regulatory mapping** shows examiners and auditors which control satisfies which requirement.
6. The **model card** documents the system in one place.

## Frameworks referenced

- Federal Reserve SR 11-7 and OCC Bulletin 2011-12, *Supervisory Guidance on Model Risk Management*
- OCC Comptroller's Handbook, *Model Risk Management* (2021)
- Equal Credit Opportunity Act and Regulation B (12 CFR Part 1002)
- Fair Credit Reporting Act (15 U.S.C. § 1681 et seq.)
- Fair Housing Act (42 U.S.C. § 3601 et seq.)
- Interagency Guidance on Third-Party Relationships: Risk Management (June 2023)
- NIST AI Risk Management Framework 1.0 and Generative AI Profile (NIST AI 600-1)
- Gramm-Leach-Bliley Act (GLBA) privacy and safeguards rules

## Author

Victory ([@Victory-max](https://github.com/Victory-max)). Interested in AI governance, data governance and databases.
