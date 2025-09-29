-- AutoForge Motors: Navigation Function Queries
-- Month-over-month revenue growth (%)
WITH monthly_totals AS (
    SELECT 
        TO_CHAR(sale_date, 'YYYY-MM') AS month,
        SUM(total_amount) AS revenue
    FROM sales
    GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
)
SELECT 
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) AS prev_month,
    ROUND((revenue - LAG(revenue, 1) OVER (ORDER BY month)) / NULLIF(LAG(revenue, 1) OVER (ORDER BY month), 0) * 100, 2) AS mom_growth_pct
FROM monthly_totals
ORDER BY month;

-- 3.2 LEAD: Next month forecast
WITH monthly_rev AS (
    SELECT 
        TO_CHAR(sale_date, 'YYYY-MM') AS month,
        SUM(total_amount) AS revenue
    FROM sales
    GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
)
SELECT 
    month,
    revenue,
    LEAD(revenue, 1) OVER (ORDER BY month) AS next_month_revenue
FROM monthly_rev
ORDER BY month;