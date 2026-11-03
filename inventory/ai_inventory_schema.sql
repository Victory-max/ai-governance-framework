-- =====================================================================
-- AI Inventory Database
-- Sample Community Bank (fictional)
--
-- Supports: AI Governance Policy Section 5 (inventory),
--           SR 11-7 Section VI (firm-wide model inventory).
-- Target: MySQL 8.0+
-- =====================================================================

CREATE DATABASE IF NOT EXISTS ai_governance;
USE ai_governance;

-- ---------------------------------------------------------------------
-- People who own, build or validate AI systems
-- ---------------------------------------------------------------------
CREATE TABLE person (
    person_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    job_title     VARCHAR(100),
    department    VARCHAR(100),
    line_of_defense TINYINT CHECK (line_of_defense IN (1, 2, 3)),
    email         VARCHAR(150) UNIQUE
);

-- ---------------------------------------------------------------------
-- Vendors supplying AI systems
-- ---------------------------------------------------------------------
CREATE TABLE vendor (
    vendor_id          INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name        VARCHAR(150) NOT NULL,
    tprm_risk_rating   ENUM('Low', 'Moderate', 'High', 'Critical'),
    last_due_diligence DATE,
    documentation_access ENUM('Full', 'Partial', 'None') NOT NULL DEFAULT 'None'
);

-- ---------------------------------------------------------------------
-- The inventory: one row per AI system
-- ---------------------------------------------------------------------
CREATE TABLE ai_system (
    system_id        VARCHAR(10) PRIMARY KEY,           -- e.g. 'AI-0001'
    system_name      VARCHAR(150) NOT NULL,
    description      TEXT,
    business_line    VARCHAR(100) NOT NULL,
    use_case_type    ENUM('Credit Decision', 'Pricing', 'Fraud', 'AML',
                          'Customer Service', 'Marketing', 'Operations',
                          'Internal Productivity', 'Other') NOT NULL,
    ai_technique     ENUM('Logistic Regression', 'Tree Ensemble', 'Neural Network',
                          'Large Language Model', 'NLP', 'Rules + ML', 'Other') NOT NULL,
    customer_facing  BOOLEAN NOT NULL DEFAULT FALSE,
    makes_credit_decisions BOOLEAN NOT NULL DEFAULT FALSE,
    uses_personal_data     BOOLEAN NOT NULL DEFAULT FALSE,
    risk_score       TINYINT CHECK (risk_score BETWEEN 7 AND 21),
    risk_tier        TINYINT NOT NULL CHECK (risk_tier IN (1, 2, 3)),
    status           ENUM('Proposed', 'In Development', 'In Validation',
                          'Approved', 'In Production', 'Retired') NOT NULL,
    owner_id         INT NOT NULL,
    developer_id     INT,
    vendor_id        INT NULL,                          -- NULL = built in-house
    date_registered  DATE NOT NULL,
    production_date  DATE,
    retirement_date  DATE,
    last_owner_attestation DATE,
    FOREIGN KEY (owner_id)     REFERENCES person(person_id),
    FOREIGN KEY (developer_id) REFERENCES person(person_id),
    FOREIGN KEY (vendor_id)    REFERENCES vendor(vendor_id),
    -- Policy override: credit decision systems are always Tier 1
    CHECK (makes_credit_decisions = FALSE OR risk_tier = 1)
);

-- ---------------------------------------------------------------------
-- Independent validations
-- ---------------------------------------------------------------------
CREATE TABLE validation (
    validation_id    INT AUTO_INCREMENT PRIMARY KEY,
    system_id        VARCHAR(10) NOT NULL,
    validation_type  ENUM('Initial', 'Periodic', 'Change-Triggered', 'Targeted') NOT NULL,
    validator_id     INT NOT NULL,
    start_date       DATE NOT NULL,
    completion_date  DATE,
    outcome          ENUM('Approved', 'Approved with Conditions', 'Not Approved', 'In Progress')
                     NOT NULL DEFAULT 'In Progress',
    next_validation_due DATE,
    FOREIGN KEY (system_id)    REFERENCES ai_system(system_id),
    FOREIGN KEY (validator_id) REFERENCES person(person_id)
);

-- ---------------------------------------------------------------------
-- Findings raised by validators, audit or monitoring
-- ---------------------------------------------------------------------
CREATE TABLE finding (
    finding_id     INT AUTO_INCREMENT PRIMARY KEY,
    system_id      VARCHAR(10) NOT NULL,
    validation_id  INT NULL,
    source         ENUM('Validation', 'Monitoring', 'Internal Audit', 'Regulator', 'Incident') NOT NULL,
    category       ENUM('Data', 'Conceptual Soundness', 'Performance', 'Fair Lending',
                        'Explainability', 'Security', 'Implementation', 'Documentation') NOT NULL,
    severity       ENUM('High', 'Medium', 'Low') NOT NULL,
    description    TEXT NOT NULL,
    date_raised    DATE NOT NULL,
    due_date       DATE NOT NULL,
    date_closed    DATE,
    FOREIGN KEY (system_id)     REFERENCES ai_system(system_id),
    FOREIGN KEY (validation_id) REFERENCES validation(validation_id)
);

-- ---------------------------------------------------------------------
-- Monitoring results against thresholds
-- ---------------------------------------------------------------------
CREATE TABLE monitoring_result (
    result_id      INT AUTO_INCREMENT PRIMARY KEY,
    system_id      VARCHAR(10) NOT NULL,
    period_end     DATE NOT NULL,
    metric_name    VARCHAR(60) NOT NULL,   -- e.g. 'PSI', 'AUC', 'AIR_Black_White', 'Override_Rate'
    metric_value   DECIMAL(8,4) NOT NULL,
    threshold_low  DECIMAL(8,4),           -- breach if value < threshold_low
    threshold_high DECIMAL(8,4),           -- breach if value > threshold_high
    FOREIGN KEY (system_id) REFERENCES ai_system(system_id)
);

-- ---------------------------------------------------------------------
-- Approved policy exceptions (Policy Section 9)
-- ---------------------------------------------------------------------
CREATE TABLE policy_exception (
    exception_id   INT AUTO_INCREMENT PRIMARY KEY,
    system_id      VARCHAR(10) NOT NULL,
    description    TEXT NOT NULL,
    approved_by    VARCHAR(100) NOT NULL,
    approved_date  DATE NOT NULL,
    expiry_date    DATE NOT NULL,
    FOREIGN KEY (system_id) REFERENCES ai_system(system_id)
);


-- =====================================================================
-- SAMPLE DATA (fictional)
-- =====================================================================

INSERT INTO person (full_name, job_title, department, line_of_defense, email) VALUES
 ('Dana Brooks',   'Head of Consumer Lending',  'Consumer Lending',     1, 'dbrooks@example.com'),
 ('Sam Patel',     'Lead Data Scientist',      'Credit Risk Analytics',1, 'spatel@example.com'),
 ('Jordan Lee',    'Head of Model Risk',       'Model Risk Management',2, 'jlee@example.com'),
 ('Alex Romero',   'Senior Model Validator',   'Model Risk Management',2, 'aromero@example.com'),
 ('Morgan Chen',   'BSA Officer',              'Financial Crimes',     1, 'mchen@example.com'),
 ('Taylor Grant',  'Head of Digital Banking',  'Digital Banking',      1, 'tgrant@example.com');

INSERT INTO vendor (vendor_name, tprm_risk_rating, last_due_diligence, documentation_access) VALUES
 ('Example AML Analytics Inc.', 'High',     '2026-02-15', 'Partial'),
 ('Example Chat AI LLC',        'Critical', '2026-05-01', 'Partial');

INSERT INTO ai_system (system_id, system_name, description, business_line, use_case_type,
    ai_technique, customer_facing, makes_credit_decisions, uses_personal_data,
    risk_score, risk_tier, status, owner_id, developer_id, vendor_id,
    date_registered, production_date, last_owner_attestation) VALUES
 ('AI-0001', 'Consumer Loan Approval Model v2.0',
  'Recommends approve/refer/decline for unsecured personal loans',
  'Consumer Lending', 'Credit Decision', 'Tree Ensemble', TRUE, TRUE, TRUE,
  18, 1, 'In Validation', 1, 2, NULL, '2026-01-10', NULL, '2026-10-01'),
 ('AI-0002', 'AML Transaction Monitoring',
  'Scores transactions for suspicious activity alerts',
  'Financial Crimes', 'AML', 'Rules + ML', FALSE, FALSE, TRUE,
  17, 1, 'In Production', 5, NULL, 1, '2024-06-01', '2024-09-15', '2026-07-01'),
 ('AI-0003', 'Customer Service Chat Assistant',
  'Generative AI assistant answering customer questions in the mobile app',
  'Digital Banking', 'Customer Service', 'Large Language Model', TRUE, FALSE, TRUE,
  16, 1, 'Proposed', 6, NULL, 2, '2026-09-20', NULL, NULL),
 ('AI-0004', 'Consumer Loan Scorecard v1.0',
  'Previous logistic regression scorecard, to be replaced by AI-0001',
  'Consumer Lending', 'Credit Decision', 'Logistic Regression', TRUE, TRUE, TRUE,
  15, 1, 'In Production', 1, 2, NULL, '2022-03-01', '2022-06-01', '2026-04-01');

INSERT INTO validation (system_id, validation_type, validator_id, start_date,
    completion_date, outcome, next_validation_due) VALUES
 ('AI-0004', 'Periodic',  4, '2025-03-01', '2025-04-15', 'Approved',                 '2026-04-15'),
 ('AI-0002', 'Initial',   4, '2024-07-01', '2024-09-01', 'Approved with Conditions', '2025-09-01'),
 ('AI-0001', 'Initial',   4, '2026-08-01', NULL,         'In Progress',              NULL);

INSERT INTO finding (system_id, validation_id, source, category, severity,
    description, date_raised, due_date, date_closed) VALUES
 ('AI-0001', 3, 'Validation', 'Explainability', 'High',
  'SHAP reason codes unstable for applicants near the decline cut-off',
  '2026-09-12', '2026-12-12', NULL),
 ('AI-0001', 3, 'Validation', 'Fair Lending', 'Medium',
  'LDA search did not test removing number of recent inquiries',
  '2026-09-12', '2026-12-12', NULL),
 ('AI-0002', 2, 'Validation', 'Documentation', 'Medium',
  'Vendor has not provided full feature list',
  '2024-09-01', '2024-12-01', NULL),
 ('AI-0004', 1, 'Validation', 'Performance', 'Low',
  'Calibration drift in highest score band',
  '2025-04-15', '2025-10-15', '2025-09-30');

INSERT INTO monitoring_result (system_id, period_end, metric_name, metric_value,
    threshold_low, threshold_high) VALUES
 ('AI-0004', '2026-09-30', 'PSI',             0.0800, NULL,   0.2500),
 ('AI-0004', '2026-09-30', 'AUC',             0.7100, 0.6900, NULL),
 ('AI-0004', '2026-09-30', 'AIR_Black_White', 0.7900, 0.8000, NULL),
 ('AI-0004', '2026-09-30', 'Override_Rate',   0.0600, NULL,   0.1000),
 ('AI-0002', '2026-09-30', 'Alert_Rate',      0.0310, NULL,   0.0500);


-- =====================================================================
-- REPORTING QUERIES
-- =====================================================================

-- 1. Inventory summary by tier and status (Board Risk Committee report)
SELECT risk_tier, status, COUNT(*) AS systems
FROM ai_system
GROUP BY risk_tier, status
ORDER BY risk_tier, status;

-- 2. Overdue validations: in production but next validation date has passed
SELECT s.system_id, s.system_name, s.risk_tier, v.next_validation_due,
       DATEDIFF(CURRENT_DATE, v.next_validation_due) AS days_overdue
FROM ai_system s
JOIN validation v ON v.system_id = s.system_id
WHERE s.status = 'In Production'
  AND v.completion_date = (SELECT MAX(v2.completion_date)
                           FROM validation v2 WHERE v2.system_id = s.system_id)
  AND v.next_validation_due < CURRENT_DATE
ORDER BY days_overdue DESC;

-- 3. Open High findings, and whether they are past due
SELECT f.system_id, s.system_name, f.category, f.description, f.due_date,
       CASE WHEN f.due_date < CURRENT_DATE THEN 'PAST DUE' ELSE 'Open' END AS state
FROM finding f
JOIN ai_system s ON s.system_id = f.system_id
WHERE f.severity = 'High' AND f.date_closed IS NULL
ORDER BY f.due_date;

-- 4. Monitoring threshold breaches in the latest period
SELECT m.system_id, s.system_name, m.period_end, m.metric_name, m.metric_value,
       m.threshold_low, m.threshold_high
FROM monitoring_result m
JOIN ai_system s ON s.system_id = m.system_id
WHERE (m.threshold_low  IS NOT NULL AND m.metric_value < m.threshold_low)
   OR (m.threshold_high IS NOT NULL AND m.metric_value > m.threshold_high)
ORDER BY m.period_end DESC, m.system_id;

-- 5. Fair lending watch list: credit decision systems with an adverse impact
--    ratio below 0.80 in any monitoring period
SELECT s.system_id, s.system_name, m.period_end, m.metric_name, m.metric_value
FROM ai_system s
JOIN monitoring_result m ON m.system_id = s.system_id
WHERE s.makes_credit_decisions = TRUE
  AND m.metric_name LIKE 'AIR%'
  AND m.metric_value < 0.80;

-- 6. Owner attestations more than 3 months old (Policy Section 5)
SELECT s.system_id, s.system_name, p.full_name AS owner, s.last_owner_attestation
FROM ai_system s
JOIN person p ON p.person_id = s.owner_id
WHERE s.status <> 'Retired'
  AND (s.last_owner_attestation IS NULL
       OR s.last_owner_attestation < DATE_SUB(CURRENT_DATE, INTERVAL 3 MONTH));

-- 7. Vendor AI systems with limited documentation access (TPRM concern)
SELECT s.system_id, s.system_name, v.vendor_name, v.tprm_risk_rating, v.documentation_access
FROM ai_system s
JOIN vendor v ON v.vendor_id = s.vendor_id
WHERE v.documentation_access <> 'Full';
