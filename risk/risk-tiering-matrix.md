# AI Risk-Tiering Matrix

The tier decides how much oversight an AI system gets (see Policy Section 6). Score each factor 1–3, then add them up.

## Scoring factors

| # | Factor | 1 (Low) | 2 (Medium) | 3 (High) |
|---|---|---|---|---|
| 1 | **Customer impact** | No direct customer effect | Affects customer experience or service | Decides or strongly influences access to credit, accounts, pricing or other financial outcomes |
| 2 | **Regulatory exposure** | No specific regulation | General rules (UDAAP, privacy) | Fair lending (ECOA, Fair Housing Act), FCRA, BSA/AML |
| 3 | **Degree of automation** | Information only; human decides | Recommendation that humans usually follow | Decision made automatically or with little review |
| 4 | **Financial materiality** | Under $100K potential impact | $100K – $5M | Over $5M, or affects capital, reserves or loss estimates |
| 5 | **Complexity and explainability** | Simple rules or linear model; easy to explain | Moderately complex; explainable with tools | Complex (ensemble, neural net, LLM); hard to explain |
| 6 | **Data sensitivity** | Public or internal non-personal data | Personal data, low sensitivity | Credit data, financial data, or data that may proxy for protected traits |
| 7 | **Vendor dependence** | Built in-house, fully documented | Vendor with good documentation access | Vendor "black box" with limited transparency |

## Tier assignment

| Total score | Tier |
|---|---|
| 17 – 21 | **Tier 1 (High)** |
| 11 – 16 | **Tier 2 (Medium)** |
| 7 – 10 | **Tier 3 (Low)** |

**Override rules (always Tier 1, whatever the score):**
- Any system used in credit decisions (approval, pricing, limits).
- Any system scoring 3 on Customer impact **and** 3 on Regulatory exposure.
- Any generative AI system that talks directly to customers.

The AI Governance Committee may raise a tier at any time. Lowering a tier requires its written approval.

## Worked example: consumer loan approval model

| Factor | Score | Reason |
|---|---|---|
| Customer impact | 3 | Recommends approve/decline on consumer loans |
| Regulatory exposure | 3 | ECOA/Reg B, FCRA, UDAAP |
| Degree of automation | 2 | Recommendation; underwriters review declines and borderline cases |
| Financial materiality | 3 | Drives credit losses on a portfolio over $5M |
| Complexity and explainability | 3 | Gradient-boosted trees; needs SHAP to explain |
| Data sensitivity | 3 | Credit bureau and income data |
| Vendor dependence | 1 | Built in-house |
| **Total** | **18** | **Tier 1 (High)**; also triggers the credit-decision override |

## Other examples

| AI system | Likely tier | Why |
|---|---|---|
| Consumer loan approval model | Tier 1 | Credit decision override |
| AML transaction monitoring model | Tier 1 | BSA/AML exposure, high materiality |
| Customer service chatbot (generative AI) | Tier 1 | Customer-facing generative AI override |
| Fraud detection on card transactions | Tier 2 | Customer impact, but humans review alerts |
| Internal document search assistant | Tier 3 | Internal use, no customer decisions |
| Email spam filter | Tier 3 | Minimal impact |
