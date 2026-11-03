# Regulatory Mapping

Shows which part of the framework covers each requirement. Useful for examiners, auditors and gap analysis.

Status as of this framework's last review. Laws and guidance change; check for updates before relying on this.

## Model risk management

| Requirement | Source | Framework control |
|---|---|---|
| Sound model development, with documented purpose, data and methods | SR 11-7 / OCC 2011-12 §IV | Policy §7.2; Validation checklist A–C |
| Independent validation with effective challenge | SR 11-7 §V | Policy §4 (MRM role), §7.3; Validation checklist A |
| Conceptual soundness evaluation | SR 11-7 §V | Validation checklist C |
| Ongoing monitoring | SR 11-7 §V | Policy §7.5; Validation checklist I |
| Outcomes analysis and back-testing | SR 11-7 §V | Validation checklist D |
| Firm-wide model inventory | SR 11-7 §VI | Policy §5; `ai_inventory_schema.sql` |
| Board and senior management oversight | SR 11-7 §VI | Policy §4, §10 |
| Policies, procedures and internal audit | SR 11-7 §VI | Policy §4 (Internal Audit), §11 |
| Vendor model controls | SR 11-7 §V; Interagency TPRM Guidance (2023) | Policy §7.2; Risk-tiering factor 7 |

## Fair lending and consumer protection

| Requirement | Source | Framework control |
|---|---|---|
| No discrimination on a prohibited basis in any aspect of a credit transaction | ECOA, 15 U.S.C. §1691; Reg B 12 CFR 1002.4 | Policy §7.2, §8; Validation checklist B, E |
| Disparate impact must be justified and less discriminatory alternatives considered | ECOA / Fair Housing Act case law and agency practice | Validation checklist E (LDA search) |
| Specific, accurate reasons for adverse action | Reg B 12 CFR 1002.9 | Validation checklist F; Policy §8 |
| Adverse action notice when consumer report data is used | FCRA §615(a), 15 U.S.C. §1681m | Validation checklist F |
| Permissible purpose for credit report use | FCRA §604 | Validation checklist B |
| Credit records kept 25 months | Reg B 12 CFR 1002.12 | Policy §7.6 |
| No unfair, deceptive or abusive practices | Dodd-Frank Act §1031, 1036 (UDAAP) | Policy §3, §8; Compliance role in Policy §4 |
| Fair housing in mortgage lending | Fair Housing Act, 42 U.S.C. §3605 | Validation checklist E (if mortgage products in scope) |

## Data, privacy and security

| Requirement | Source | Framework control |
|---|---|---|
| Protect customer information | GLBA Safeguards (Interagency Guidelines, 12 CFR Part 30 App. B for OCC banks) | Policy §3, §8; Validation checklist G |
| Limits on sharing nonpublic personal information | GLBA Privacy / Reg P | Policy §8 (generative AI data restriction) |
| Accurate, governed risk data | Data governance best practice; BCBS 239 for large banks | Validation checklist B |

## Third-party risk

| Requirement | Source | Framework control |
|---|---|---|
| Risk-based due diligence, contract terms and ongoing monitoring of vendors | Interagency Guidance on Third-Party Relationships (June 2023) | Policy §4 (TPRM role), §7.2 |
| Access to vendor documentation and testing | Interagency TPRM Guidance; SR 11-7 | Policy §7.2 |

## Voluntary framework: NIST AI RMF 1.0

| NIST function | What it means | Framework control |
|---|---|---|
| **Govern** | Policies, roles, accountability, culture | Policy §3–§4, §9–§10 |
| **Map** | Understand context, use and impacts of each system | Inventory; Risk-tiering matrix; Model card |
| **Measure** | Test and track risks: performance, fairness, robustness | Validation checklist C–G |
| **Manage** | Prioritise and respond to risks; monitor; handle incidents | Policy §7.5, §9; Validation checklist I |

## Areas to watch

- **State AI laws.** The Colorado AI Act covers high-risk AI decisions, including lending. Its effective date has been delayed and federal efforts to preempt state AI laws are ongoing. Confirm current status.
- **CFPB guidance.** Some AI-related CFPB guidance documents were withdrawn in 2025. The underlying ECOA, Reg B and FCRA requirements are unchanged.
- **NYDFS.** New York-licensed banks should add Part 500 cybersecurity requirements and NYDFS guidance on AI-related cyber risk.
- **Generative AI.** If the bank adds generative AI, map controls to the NIST Generative AI Profile (NIST AI 600-1).
