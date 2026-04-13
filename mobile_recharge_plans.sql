-- Mobile Recharge Plans Database Schema
-- Created: February 2026
-- Carriers: Airtel, Jio, BSNL, Vi
create database ors
use ors
-- ============================================
-- 1. CARRIERS TABLE
-- ============================================
CREATE TABLE carriers (
    carrier_id INT PRIMARY KEY AUTO_INCREMENT,
    carrier_name VARCHAR(50) NOT NULL UNIQUE,
    carrier_code VARCHAR(10) NOT NULL UNIQUE,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 2. RECHARGE PLANS TABLE
-- ============================================
CREATE TABLE recharge_plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    carrier_id INT NOT NULL,
    plan_name VARCHAR(100),
    plan_price DECIMAL(10, 2) NOT NULL,
    validity_days INT NOT NULL,
    data_per_day VARCHAR(50),
    total_data VARCHAR(50),
    unlimited_calls BOOLEAN DEFAULT FALSE,
    sms_per_day INT DEFAULT 0,
    total_sms INT DEFAULT 0,
    unlimited_5g BOOLEAN DEFAULT FALSE,
    plan_type ENUM('prepaid', 'data_only', 'voice_only', 'annual', 'special') DEFAULT 'prepaid',
    ott_benefits TEXT,
    additional_benefits TEXT,
    plan_description TEXT,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (carrier_id) REFERENCES carriers(carrier_id)
);

-- ============================================
-- INSERT CARRIERS
-- ============================================
INSERT INTO carriers (carrier_name, carrier_code) VALUES
('Airtel', 'AIRT'),
('Jio', 'JIO'),
('BSNL', 'BSNL'),
('Vi', 'VI');

-- ============================================
-- AIRTEL PLANS
-- ============================================

-- Airtel Popular Plans (28 days)
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(1, 'Airtel Rs 349 Plan', 349.00, 28, '2GB', TRUE, 100, TRUE, 'prepaid', 'Xstream Play Premium (20+ OTT apps), Sony LIV, Lionsgate Play, Aha, Chaupal, Hoichoi, Sun NXT', 'Perplexity Pro AI (12 months), Apple Music (6 months), Adobe Express Premium'),
(1, 'Airtel Rs 399 Plan', 399.00, 28, 'Unlimited', TRUE, 100, TRUE, 'prepaid', 'Airtel Xstream Play', 'Unlimited 4G/5G data (300GB FUP), Adobe Express Premium, Perplexity Pro AI (12 months), Free HelloTunes'),
(1, 'Airtel Rs 449 Plan', 449.00, 28, 'Unlimited', TRUE, 100, TRUE, 'prepaid', 'JioHotstar Mobile (28 days), SonyLIV, Airtel Xstream Play (19 OTT services)', 'Unlimited data (300GB FUP), Google One (30GB cloud), Apple Music (6 months), Free HelloTunes'),
(1, 'Airtel Rs 199 Plan', 199.00, 28, '2GB', TRUE, 100, TRUE, 'prepaid', 'Airtel Xstream App free content', 'Perplexity Pro AI (12 months), Free Hellotunes'),
(1, 'Airtel Rs 299 Plan', 299.00, 28, '1GB', TRUE, 100, TRUE, 'prepaid', NULL, 'Unlimited 5G data (claim via Airtel Thanks App)');

-- Airtel Mid-term Plans (56-84 days)
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(1, 'Airtel Rs 579 Plan', 579.00, 56, '1.5GB', TRUE, 100, TRUE, 'prepaid', 'Airtel Xstream App', 'Perplexity Pro AI (12 months), Free Hellotunes'),
(1, 'Airtel Rs 979 Plan', 979.00, 84, '2GB', TRUE, 100, TRUE, 'prepaid', 'Airtel Xstream Play (84 days)', 'Cashback up to Rs 80/month for 3 months with Airtel Mini Rewards');

-- Airtel Annual Plans (365 days)
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, total_sms, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(1, 'Airtel Rs 979 Annual Voice Plan', 979.00, 365, NULL, TRUE, 3600, FALSE, 'voice_only', NULL, 'Perplexity Pro AI (12 months), Free Hellotunes'),
(1, 'Airtel Rs 2249 Annual Plan', 2249.00, 365, '30GB', TRUE, 3600, FALSE, 'annual', NULL, 'Perplexity Pro AI (12 months), Free Hellotunes'),
(1, 'Airtel Rs 3999 Annual Plan', 3999.00, 365, '912.5GB (2.5GB/day)', TRUE, 100, TRUE, 'annual', 'JioHotstar Mobile (1 year)', 'Unlimited 5G data (300GB per 30 days FUP), Perplexity Pro AI worth Rs 17,000 (12 months), Free Hellotunes'),
(1, 'Airtel Rs 4000 International Roaming Plan', 4000.00, 365, '547.5GB (1.5GB/day in India)', TRUE, 100, FALSE, 'annual', NULL, 'India: 1.5GB/day, unlimited calls, 100 SMS/day. International (180+ countries): 5GB data, 100 mins, 100 SMS');

-- Airtel Data Only Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, sms_per_day, plan_type, additional_benefits) VALUES
(1, 'Airtel Rs 49 Plan', 49.00, 1, 'Unlimited (20GB/day FUP)', FALSE, 0, 'data_only', 'Speed reduces after 20GB/day'),
(1, 'Airtel Rs 99 Plan', 99.00, 2, 'Unlimited (20GB/day FUP)', FALSE, 0, 'data_only', 'Speed reduces after 20GB/day'),
(1, 'Airtel Rs 181 Plan (6GB)', 181.00, 30, '6GB', FALSE, 0, 'data_only', NULL),
(1, 'Airtel Rs 265 Plan (12GB)', 265.00, 30, '12GB', FALSE, 0, 'data_only', NULL),
(1, 'Airtel Rs 361 Plan (50GB)', 361.00, 30, '50GB', FALSE, 0, 'data_only', 'Data charged at 50p/MB after consumption');

-- ============================================
-- JIO PLANS
-- ============================================

-- Jio Happy New Year 2026 Special Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(2, 'Jio Flexi Pack', 103.00, 28, '5GB', NULL, FALSE, 0, FALSE, 'prepaid', 'One OTT pack (Hindi/International/Regional)', 'Most affordable option'),
(2, 'Jio Super Celebration Plan', 500.00, 28, '56GB (2GB/day)', '2GB', TRUE, 100, TRUE, 'prepaid', 'YouTube Premium, JioHotstar, Amazon Prime Video, Sony LIV, ZEE5, Lionsgate Play, Discovery+, Sun NXT, FanCode, Hoichoi, Planet Marathi, Chaupal, Kanccha Lanka', 'Google Gemini Pro (worth Rs 35,100)'),
(2, 'Jio Hero Annual Plan', 3599.00, 365, '912.5GB (2.5GB/day)', '2.5GB', TRUE, 100, TRUE, 'annual', 'JioTV, JioAICloud', 'Google Gemini Pro AI (18 months, worth Rs 35,100), Unlimited 5G data, Data rolls over daily/weekly/monthly');

-- Jio Standard 28-Day Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(2, 'Jio Rs 199 Plan', 199.00, 28, '1GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Speed drops to 64Kbps after daily limit'),
(2, 'Jio Rs 299 Plan', 299.00, 28, '1.5GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Speed drops to 64Kbps after daily limit, Suitable for streaming'),
(2, 'Jio Rs 349 Plan', 349.00, 28, '2GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Unlimited 5G data, Speed drops to 64Kbps after daily limit'),
(2, 'Jio Rs 399 Plan', 399.00, 28, '2.5GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Unlimited 5G data, Good balance of data and cost'),
(2, 'Jio Rs 445 Plan', 445.00, 28, '2GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Unlimited 5G data'),
(2, 'Jio Rs 449 Plan', 449.00, 28, '3GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'High daily data for intensive monthly use');

-- Jio Mid-term Plans (84-98 days)
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(2, 'Jio Rs 999 Plan', 999.00, 98, '2GB', TRUE, 100, TRUE, 'prepaid', 'JioTV, JioAICloud', 'Longer validity than most mid-range plans'),
(2, 'Jio Rs 1029 Plan', 1029.00, 84, '2GB', TRUE, 100, TRUE, 'prepaid', 'Amazon Prime benefits, JioTV, JioAICloud', 'Unlimited 5G data'),
(2, 'Jio Rs 1049 Plan', 1049.00, 84, '2GB', TRUE, 100, TRUE, 'prepaid', 'SonyLIV, Zee5, JioTV, JioAICloud', 'For streaming content enthusiasts'),
(2, 'Jio Rs 1299 Plan', 1299.00, 84, '2GB', TRUE, 100, TRUE, 'prepaid', 'Multiple OTT subscriptions, JioTV, JioAICloud', 'Suitable for heavy entertainment users');

-- Jio Voice Only Plan
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, total_sms, plan_type, ott_benefits) VALUES
(2, 'Jio Rs 1748 Voice Plan', 1748.00, 336, NULL, TRUE, 3600, 'voice_only', 'JioTV, JioAICloud');

-- Jio Data Add-ons
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, plan_type, additional_benefits) VALUES
(2, 'Jio Rs 26 Data Pack', 26.00, 28, '2GB', FALSE, 'data_only', 'Cheapest data add-on'),
(2, 'Jio Rs 61 Data Pack', 61.00, 28, '6GB', FALSE, 'data_only', NULL),
(2, 'Jio Rs 100 Data Pack', 100.00, 28, '140GB (5GB/day)', FALSE, 'data_only', 'High data for heavy users');

-- ============================================
-- BSNL PLANS
-- ============================================

-- BSNL Special Annual Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, plan_type, plan_description, additional_benefits) VALUES
(3, 'BSNL Rs 2799 Annual Plan', 2799.00, 365, '3GB', TRUE, 100, 'annual', 'Best long-term plan with unlimited calls & 3GB daily data', 'Freeze the Price offer, No monthly recharge hassle'),
(3, 'BSNL Bharat Connect 26 Plan', 2626.00, 365, '2.6GB', TRUE, 100, 'special', 'Special Republic Day plan', 'Total 949GB data, Speed reduces to 40Kbps after daily limit, Available till Feb 24, 2026'),
(3, 'BSNL Rs 2026 Plan', 2026.00, 65, NULL, TRUE, 0, 'voice_only', 'Voice-centric 65-day plan', '2GB total data, Unlimited voice calls, Good for voice-heavy users');

-- BSNL Monthly Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, total_data, unlimited_calls, sms_per_day, plan_type, additional_benefits) VALUES
(3, 'BSNL Rs 108 Plan', 108.00, 28, NULL, NULL, TRUE, 0, 'voice_only', 'Basic unlimited voice call plan'),
(3, 'BSNL Rs 198 Plan', 198.00, 30, '2GB', NULL, FALSE, 0, 'data_only', 'Data charged at 3p per 10KB after quota'),
(3, 'BSNL Rs 189 Plan', 189.00, 28, '1GB', NULL, TRUE, 100, 'prepaid', 'Budget-friendly plan'),
(3, 'BSNL Rs 219 Plan', 219.00, 28, '2GB', NULL, TRUE, 100, 'prepaid', 'Popular monthly plan');

-- BSNL Work From Home Data Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, plan_type, ott_benefits, additional_benefits) VALUES
(3, 'BSNL Rs 151 WFH Plan', 151.00, 28, '40GB', FALSE, 'data_only', 'ZING subscription', 'Work from home data pack'),
(3, 'BSNL Rs 251 WFH Plan', 251.00, 28, '70GB', FALSE, 'data_only', 'ZING subscription', '30GB more than Rs 151 plan');

-- BSNL Data Only Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, plan_type, additional_benefits) VALUES
(3, 'BSNL Rs 16 Data Pack', 16.00, 1, '2GB', FALSE, 'data_only', 'One day validity, charged 3p per 10KB after'),
(3, 'BSNL Rs 105 Data Pack', 105.00, 20, '20GB', FALSE, 'data_only', 'Charged 3p per 10KB after consumption');

-- ============================================
-- VI (VODAFONE IDEA) PLANS
-- ============================================

-- Vi Annual Plans (Multiple Circles)
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits, plan_description) VALUES
(4, 'Vi Rs 1770 Voice Plan', 1770.00, 365, NULL, TRUE, 0, FALSE, 'voice_only', NULL, 'Available in Assam, HP, J&K, NE, Odisha', 'Voice-only with 3600 total SMS'),
(4, 'Vi Rs 1849 Voice Plan', 1849.00, 365, NULL, TRUE, 0, FALSE, 'voice_only', NULL, 'Available in AP/TS, Bihar, Chennai, Delhi, Gujarat, Haryana, Karnataka, Kerala, Kolkata, MH/Goa, MP, Mumbai, Punjab, Rajasthan, TN, UP East, UP West, WB', 'Voice-only with 3600 total SMS'),
(4, 'Vi Rs 2249 Plan', 2249.00, 365, NULL, TRUE, 0, FALSE, 'annual', NULL, 'Voice-centric with limited data', 'Available in multiple circles'),
(4, 'Vi Hero Unlimited Plan', 2999.00, 365, '2GB', TRUE, 100, TRUE, 'annual', 'Amazon Prime Lite (1 year), Prime Video HD 720p', 'Extra 50GB for 90 days, Unlimited 5G data, AP/TS, Bihar, Karnataka, MP, Rajasthan',NULL),
(4, 'Vi Super Hero Plan', 3199.00, 365, '2GB', TRUE, 100, TRUE, 'annual', 'Amazon Prime Lite (1 year), Prime Video HD 720p', 'Extra 50GB for 90 days, Unlimited 5G data, Available in Chennai, Delhi, Gujarat, Haryana, Kerala, Kolkata, MH/Goa, Mumbai, Punjab, TN, UP East, UP West, WB'),
(4, 'Vi NonStop Hero Plan', 3799.00, 365, 'Unlimited', TRUE, 100, TRUE, 'annual', 'Vi Movies & TV Super (1 year), Amazon Prime Lite', 'Unlimited data, Available in Assam, HP, J&K, NE, Odisha',NULL);

-- Vi 28-Day Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(4, 'Vi Rs 99 Plan', 99.00, 28, NULL, FALSE, 0, FALSE, 'prepaid', NULL, 'Rs 75.75 talktime balance'),
(4, 'Vi Rs 199 Plan', 199.00, 28, '1GB', TRUE, 100, FALSE, 'prepaid', NULL, 'Night unlimited data (12AM-6AM), Weekend data rollover'),
(4, 'Vi Rs 299 Plan', 299.00, 28, '1.5GB', TRUE, 100, TRUE, 'prepaid', 'Vi Movies & TV', 'Night unlimited data, Weekend rollover, Backup 2GB/month'),
(4, 'Vi Rs 349 Plan', 349.00, 28, '2GB', TRUE, 100, TRUE, 'prepaid', 'Vi Movies & TV', 'Unlimited 5G, Night data, Weekend rollover'),
(4, 'Vi Rs 399 Plan', 399.00, 28, 'Unlimited (300GB FUP)', TRUE, 100, TRUE, 'prepaid', 'JioHotstar (1 month)', 'Unlimited data 12PM-12PM or 12AM-6AM depending on pack'),
(4, 'Vi Rs 449 Plan', 449.00, 28, '3GB', TRUE, 100, TRUE, 'prepaid', 'SonyLIV, Zee5, Lionsgate Play, 19 OTT services', 'Unlimited data all day (no time restriction)');

-- Vi 56-Day Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, data_per_day, unlimited_calls, sms_per_day, unlimited_5g, plan_type, ott_benefits, additional_benefits) VALUES
(4, 'Vi Rs 579 Plan', 579.00, 56, '1.5GB', TRUE, 100, TRUE, 'prepaid', 'Vi Movies & TV', 'Night unlimited data, Weekend rollover'),
(4, 'Vi Rs 699 Plan', 699.00, 56, '2GB', TRUE, 100, TRUE, 'prepaid', 'Vi Movies & TV, OTT apps', 'Night data, Weekend rollover');

-- Vi Data Only Plans
INSERT INTO recharge_plans (carrier_id, plan_name, plan_price, validity_days, total_data, unlimited_calls, plan_type, additional_benefits) VALUES
(4, 'Vi Rs 19 Data Pack', 19.00, 7, '1GB', FALSE, 'data_only', 'Basic data add-on'),
(4, 'Vi Rs 48 Data Pack', 48.00, 28, '4GB', FALSE, 'data_only', NULL),
(4, 'Vi Rs 118 Data Pack', 118.00, 28, '15GB', FALSE, 'data_only', NULL),
(4, 'Vi Rs 298 Data Pack', 298.00, 28, '50GB', FALSE, 'data_only', 'Good for heavy data needs'),
(4, 'Vi Rs 418 Data Pack', 418.00, 56, '100GB', FALSE, 'data_only', 'Highest data offering, ideal for users without broadband');

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX idx_carrier_id ON recharge_plans(carrier_id);
CREATE INDEX idx_plan_price ON recharge_plans(plan_price);
CREATE INDEX idx_validity_days ON recharge_plans(validity_days);
CREATE INDEX idx_plan_type ON recharge_plans(plan_type);
CREATE INDEX idx_active ON recharge_plans(active);

-- ============================================
-- VIEWS FOR EASY QUERYING
-- ============================================

-- View: All Active Plans with Carrier Names
CREATE VIEW v_active_plans AS
SELECT 
    p.plan_id,
    c.carrier_name,
    c.carrier_code,
    p.plan_name,
    p.plan_price,
    p.validity_days,
    p.data_per_day,
    p.total_data,
    p.unlimited_calls,
    p.sms_per_day,
    p.unlimited_5g,
    p.plan_type,
    p.ott_benefits,
    p.additional_benefits
FROM recharge_plans p
JOIN carriers c ON p.carrier_id = c.carrier_id
WHERE p.active = TRUE AND c.active = TRUE
ORDER BY c.carrier_name, p.plan_price;

-- View: Plans by Price Range
CREATE VIEW v_budget_plans AS
SELECT * FROM v_active_plans WHERE plan_price <= 300;

CREATE VIEW v_mid_range_plans AS
SELECT * FROM v_active_plans WHERE plan_price > 300 AND plan_price <= 1000;

CREATE VIEW v_premium_plans AS
SELECT * FROM v_active_plans WHERE plan_price > 1000;

-- View: Annual Plans Only
CREATE VIEW v_annual_plans AS
SELECT * FROM v_active_plans WHERE validity_days >= 365;

-- View: Plans with OTT Benefits
CREATE VIEW v_ott_plans AS
SELECT * FROM v_active_plans WHERE ott_benefits IS NOT NULL;

-- ============================================
-- SAMPLE QUERIES
-- ============================================

-- Query 1: Get all plans for a specific carrier
-- SELECT * FROM v_active_plans WHERE carrier_name = 'Airtel';

-- Query 2: Get plans within a price range
-- SELECT * FROM v_active_plans WHERE plan_price BETWEEN 200 AND 500;

-- Query 3: Get all plans with unlimited 5G
-- SELECT * FROM v_active_plans WHERE unlimited_5g = TRUE;

-- Query 4: Get annual plans sorted by price
-- SELECT * FROM v_annual_plans ORDER BY plan_price;

-- Query 5: Compare similar plans across carriers
-- SELECT carrier_name, plan_name, plan_price, data_per_day, validity_days 
-- FROM v_active_plans 
-- WHERE validity_days = 28 AND plan_price BETWEEN 300 AND 400
-- ORDER BY plan_price;

-- Query 6: Get data-only plans
-- SELECT * FROM v_active_plans WHERE plan_type = 'data_only' ORDER BY plan_price;

-- ============================================