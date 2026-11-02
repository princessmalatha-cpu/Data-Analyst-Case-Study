
-- Q1: Net Sales by Fiscal Period
CREATE OR REPLACE VIEW q01_net_sales_by_fiscal_period AS
SELECT
    d.fiscal_year,
    d.month,
    SUM(f.net_amount) AS net_sales
FROM fact_sales_line f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.fiscal_year, d.month;

-- Q2: Sales by Product Segment (using category)
CREATE OR REPLACE VIEW q02_sales_by_product_segment AS
SELECT
    p.category AS segment,
    SUM(f.net_amount) AS net_sales
FROM fact_sales_line f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category;

-- Q3: Discount by Funder
CREATE OR REPLACE VIEW q03_discount_by_funder AS
SELECT
    f.discount_funder AS funder,
    SUM(f.discount_amount) AS total_discount
FROM fact_sales_line f
GROUP BY f.discount_funder;

-- Q4: Dispensing Fee Check
CREATE OR REPLACE VIEW q04_dispensing_fee_check AS
SELECT
    SUM(f.dispensing_fee) AS total_dispensing_fee,
    SUM(f.net_amount) AS total_net_sales
FROM fact_sales_line f;

-- Q5: Top Customers
CREATE OR REPLACE VIEW q05_top_customers AS
SELECT
    f.customer_key,
    SUM(f.net_amount) AS total_spent
FROM fact_sales_line f
GROUP BY f.customer_key
ORDER BY total_spent DESC
LIMIT 10;

-- Q6: Sales by Store Region (using province as region)
CREATE OR REPLACE VIEW q06_sales_by_store_region AS
SELECT
    s.province AS region,
    SUM(f.net_amount) AS net_sales
FROM fact_sales_line f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.province;