# AI Governance Policy

**Sample Community Bank (fictional)**
Policy owner: Chief Risk Officer · Approved by: Board Risk Committee · Review cycle: annual

---

## 1. Purpose

This policy sets how the bank identifies, approves, uses, monitors and retires artificial intelligence (AI) systems. It makes sure AI is used safely, fairly, in line with law and regulation, and within the bank's risk appetite.

This policy extends the bank's **Model Risk Management Policy** (based on SR 11-7 / OCC 2011-12). Where the two overlap, the stricter requirement applies.

## 2. Scope

### 2.1 What counts as an AI system

Any system that uses machine learning, statistical learning, natural language processing or generative AI to produce predictions, scores, classifications, recommendations, content or decisions. This includes:

- Systems built in-house
- Vendor products with AI features, including features added to existing software
- Generative AI tools used by employees, such as chat assistants

### 2.2 Who it applies to

All employees, contractors and business lines, and third parties that develop or operate AI for the bank.

## 3. Principles

AI systems at the bank must be:

1. **Lawful.** Compliant with fair lending, consumer protection, privacy and banking law.
2. **Fair.** Tested for discrimination against protected groups, with less discriminatory alternatives considered.
3. **Explainable.** Able to give the specific, accurate reasons regulators and customers are entitled to.
4. **Accountable.** Every system has a named owner. Humans stay responsible for outcomes.
5. **Sound.** Conceptually sound, validated and monitored, per SR 11-7.
6. **Secure and private.** Customer data is protected under GLBA and the bank's information security program.

## 4. Roles and responsibilities (three lines of defense)

| Role | Line | Responsibilities |
|---|---|---|
| **Board Risk Committee** | Oversight | Approves this policy and AI risk appetite. Receives quarterly AI risk reports. |
| **AI Governance Committee** | 2nd line | Chaired by the CRO. Members: Chief Compliance Officer, Chief Data Officer, CISO, Head of Model Risk, General Counsel, business heads. Approves Tier 1 systems, grants exceptions, reviews incidents. |
| **Model owner** | 1st line | Accountable for an AI system's purpose, performance and use. Registers it in the inventory. Fixes issues. |
| **Model developer** | 1st line | Builds or configures the system. Produces documentation. |
| **Model Risk Management (validators)** | 2nd line | Independent validation and **effective challenge**. Must not have helped build the model. |
| **Compliance / Fair Lending** | 2nd line | Fair lending testing, adverse action notice review, UDAAP review. |
| **Information Security** | 2nd line | Security testing, data protection, generative AI controls. |
| **Third-Party Risk Management** | 2nd line | Due diligence and monitoring of AI vendors. |
| **Internal Audit** | 3rd line | Independent assurance that this policy is followed. |

## 5. AI inventory

- Every AI system must be registered in the **AI inventory** before development or purchase begins.
- The inventory records: owner, purpose, risk tier, data used, vendor (if any), validation dates, status and open issues.
- Model owners confirm their entries quarterly. Model Risk Management reconciles the inventory against procurement and IT asset records to find unregistered AI.

See [`inventory/ai_inventory_schema.sql`](../inventory/ai_inventory_schema.sql).

## 6. Risk tiering

Each system is assigned a tier using the [risk-tiering matrix](../risk/risk-tiering-matrix.md). The tier decides the controls:

| Control | Tier 1 (High) | Tier 2 (Medium) | Tier 3 (Low) |
|---|---|---|---|
| Approval | AI Governance Committee | Head of Model Risk | Model owner + MRM review |
| Independent validation before use | Full | Targeted | Lightweight review |
| Revalidation | Annual | Every 2 years | Every 3 years or on change |
| Fair lending testing | Required before use and quarterly | If used for customer decisions | Not required unless customer-facing |
| Monitoring reports | Monthly | Quarterly | Annual |
| Human review of outputs | Required for adverse decisions | Sampled | As needed |

## 7. Lifecycle requirements

### 7.1 Proposal
- Model owner submits a use-case proposal: business need, intended use, customers affected, data, alternatives considered.
- System registered in inventory; preliminary tier assigned.

### 7.2 Development or procurement
- Data sources documented, with lineage and quality checks.
- **Prohibited bases** (race, color, religion, national origin, sex, marital status, age, receipt of public assistance, good-faith exercise of Consumer Credit Protection Act rights) must not be used as inputs.
- Inputs reviewed for **proxies** of prohibited bases (for example ZIP code, certain shopping or device data).
- Vendor systems go through third-party due diligence, including the right to obtain documentation and testing results.

### 7.3 Validation
- Performed by Model Risk Management, independent of developers.
- Uses the [validation checklist](../validation/loan-model-validation-checklist.md).
- Findings rated High / Medium / Low. High findings must be fixed before use.

### 7.4 Approval and deployment
- Approval authority per Section 6.
- Change management: production deployment follows IT change control. Material changes trigger revalidation.

### 7.5 Monitoring
- Performance, data drift, fairness and override rates tracked against thresholds set at approval.
- Breaches are escalated to the model owner within 5 business days and to the AI Governance Committee if unresolved after 30 days.

### 7.6 Retirement
- Systems no longer in use are retired in the inventory. Documentation is kept per the records retention schedule (at least 25 months for credit decision records, per Regulation B).

## 8. Prohibited and restricted uses

**Prohibited:**
- Using prohibited bases, or known close proxies, to make credit decisions.
- Fully automated adverse credit decisions without the ability to produce accurate, specific reasons.
- Entering customer personal information into generative AI tools that are not approved by Information Security.

**Restricted (AI Governance Committee approval required):**
- Generative AI that communicates directly with customers.
- Use of alternative data (such as cash-flow or rent data) in credit decisions.
- AI that makes or recommends employment decisions.

## 9. Issues, incidents and exceptions

- An **AI incident** is any event where an AI system causes or could cause customer harm, legal breach, material financial loss or reputational damage.
- Incidents are reported to the model owner and Model Risk Management within 1 business day, and to the AI Governance Committee within 5 business days.
- Exceptions to this policy require written approval from the AI Governance Committee, last at most 12 months, and are tracked in the inventory.

## 10. Reporting

The AI Governance Committee reports quarterly to the Board Risk Committee:
- Number of AI systems by tier and status
- Overdue validations and open High findings
- Fairness monitoring results for Tier 1 systems
- Incidents and exceptions

## 11. Related documents

- Model Risk Management Policy
- Fair Lending Policy
- Third-Party Risk Management Policy
- Information Security Policy
- Records Retention Schedule
