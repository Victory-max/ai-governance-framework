# Work in Progress: Customer Service Chatbot Use Case

Second use case for the framework: a generative AI customer service chatbot connected to core banking.
Already in the inventory as **AI-0003, "Customer Service Chat Assistant"** (status: Proposed).

Working style: Victory makes the decisions and writes the drafts; Claude explains, reviews and helps with SQL and regulations.

## Plan

| Step | Output | Lead | Status |
|---|---|---|---|
| 1 | Scope: what the chatbot can and can't do | Victory | **In progress** |
| 2 | Risk tiering using `risk/risk-tiering-matrix.md` | Victory | Not started |
| 3 | Risks list | Victory, Claude adds gaps | Not started |
| 4 | Model card (`use-case/`) | Victory drafts, Claude reviews | Not started |
| 5 | Generative AI validation checklist: hallucination, prompt injection, data leakage | Together | Not started |
| 6 | Regulatory mapping updates (Reg E, UDAAP, GLBA, NIST AI 600-1) | Claude explains, Victory writes | Not started |
| 7 | SQL: tables for chatbot tests and incidents | Victory writes, Claude helps | Not started |
| 8 | Update README, merge to main | Claude, after Victory approves | Not started |

## Step 1: Scope

### Decided

**Q1. What can it do?** All three levels:
- **a) Information:** general answers (hours, fees, password reset help)
- **b) Account lookup:** balances and recent transactions from core banking for a logged-in customer
- **c) Transactions:** moves money (transfers, bill payments)

What each level adds:

| Level | New risks |
|---|---|
| a) Information | Wrong answers about fees or rates (UDAAP: misleading customers) |
| b) Account lookup | Showing one customer's data to another; account takeover; privacy (GLBA) |
| c) Transactions | Unauthorized transfers, fraud, Reg E. A customer reporting an unauthorized transfer in chat may start the bank's investigation deadlines |

### Still to answer

- [ ] **Rollout:** launch all at once, or phase it? (Phase 1 information, Phase 2 account lookup, Phase 3 transactions, each passing its own tests.) Give one sentence on why.
- [ ] **Q2. Who uses it?** Customers only, or staff too?
- [ ] **Q3. When does it hand over to a human?** (e.g. complaints, fraud reports, customer asks for a person)
- [ ] **Q4. What should it never do?** Two or three things.
- [ ] **Q5. How does the customer prove who they are before a transfer?** (logged into app / one-time code / biometrics)
- [ ] **Q6. Transaction limits?** (dollar limit per transfer or per day; own-accounts-only)

## How to pick up again

Start a new session with this repo, then say: *"Continue the chatbot use case from `work-in-progress/chatbot-use-case-progress.md` on the `chatbot-use-case` branch."*
