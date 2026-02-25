DROP DATABASE Stocks;
CREATE DATABASE Stocks;
USE Stocks;



CREATE TABLE Companies (
    company_id     INTEGER PRIMARY KEY,
    name           VARCHAR(255) NOT NULL,
    sector         VARCHAR(255),
    news           VARCHAR(500)
);


CREATE TABLE Security (
    security_id    INTEGER PRIMARY KEY,
    ticker         VARCHAR(20) NOT NULL UNIQUE,
    company_id     INTEGER NOT NULL,
    
    CONSTRAINT fk_security_company
        FOREIGN KEY (company_id)
        REFERENCES Companies(company_id)
        ON DELETE CASCADE
);


CREATE TABLE Valuation_Measures (
    security_id         INTEGER PRIMARY KEY,
    price_earning_ratios DECIMAL(10,2),
    dividend_yield       DECIMAL(5,2),

    CONSTRAINT fk_valuation_security
        FOREIGN KEY (security_id)
        REFERENCES Security(security_id)
        ON DELETE CASCADE
);


CREATE TABLE Security_Information (
    security_id     INTEGER NOT NULL,
    price_date      TIMESTAMP NOT NULL,
    open_price      DECIMAL(12,2),
    close_price     DECIMAL(12,2),
    high_price      DECIMAL(12,2),
    low_price       DECIMAL(12,2),
    average_volume  INTEGER,
    market_cap      BIGINT,

    PRIMARY KEY (security_id, price_date),

    CONSTRAINT fk_info_security
        FOREIGN KEY (security_id)
        REFERENCES Security(security_id)
        ON DELETE CASCADE
);


#Inserting sample data into database
INSERT INTO Companies (company_id, name, sector, news) VALUES
(1, 'Apple Inc.', 'Technology', 'Strong quarterly earnings reported.'),
(2, 'Tesla Inc.', 'Automotive', 'New EV model announced.'),
(3, 'Microsoft Corp.', 'Technology', 'Expanding cloud services globally.');


INSERT INTO Security (security_id, ticker, company_id) VALUES
(101, 'AAPL', 1),
(102, 'TSLA', 2),
(103, 'MSFT', 3);


INSERT INTO Valuation_Measures (security_id, price_earning_ratios, dividend_yield) VALUES
(101, 28.50, 0.55),
(102, 65.30, 0.00),
(103, 32.10, 0.80);


INSERT INTO Security_Information 
(security_id, price_date, open_price, close_price, high_price, low_price, average_volume, market_cap)
VALUES
-- Apple
(101, '2025-02-15 09:30:00', 185.50, 188.20, 189.00, 184.75, 75000000, 2900000000000),
(101, '2025-02-16 09:30:00', 188.50, 190.10, 191.20, 187.90, 68000000, 2920000000000),

-- Tesla
(102, '2025-02-15 09:30:00', 240.00, 245.80, 248.00, 238.50, 52000000, 780000000000),
(102, '2025-02-16 09:30:00', 246.00, 250.25, 252.40, 244.00, 49000000, 795000000000),

-- Microsoft
(103, '2025-02-15 09:30:00', 405.75, 410.10, 412.00, 404.50, 31000000, 3050000000000),
(103, '2025-02-16 09:30:00', 410.50, 415.30, 417.25, 409.80, 29500000, 3080000000000);