-- AutoForge Motors: Aggregate Function Queries

-- Running total of revenue per district
WITH monthly_rev AS (
    SELECT 
        c.region AS district,
        TO_CHAR(s.sale_date, 'YYYY-MM') AS month,
        SUM(s.total_amount) AS monthly_revenue
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.region, month
)
SELECT 
    district,
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        PARTITION BY district 
        ORDER BY month 
        ROWS UNBOUNDED PRECEDING
    ) AS running_total
FROM monthly_rev
ORDER BY district, month;

-- 2.2 3-month moving average for "SUV Terra"
WITH monthly_units AS (
    SELECT 
        TO_CHAR(s.sale_date, 'YYYY-MM') AS month,
        SUM(s.quantity) AS units
    FROM sales s
    JOIN cars ca ON s.car_id = ca.car_id
    WHERE ca.model_name = 'SUV Terra'
    GROUP BY month
)
SELECT 
    month,
    units,
    ROUND(AVG(units) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS three_month_avg
FROM monthly_units
ORDER BY month;