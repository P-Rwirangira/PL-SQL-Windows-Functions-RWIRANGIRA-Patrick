-- AutoForge Motors: Distribution Function Queries

-- Customer spending quartiles (NTILE)
WITH customer_spending AS (
    SELECT 
        s.customer_id,
        c.name,
        c.region,
        SUM(s.total_amount) AS total_spent
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY s.customer_id, c.name, c.region
)
SELECT 
    customer_id,
    name,
    region,
    total_spent,
    NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile
FROM customer_spending
ORDER BY total_spent DESC;

-- 4.2 Cumulative distribution (CUME_DIST)
WITH customer_spending AS (
    SELECT 
        c.name,
        SUM(s.total_amount) AS total_spent
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    GROUP BY c.name
)
SELECT 
    name,
    total_spent,
    ROUND(CUME_DIST() OVER (ORDER BY total_spent), 4) AS cumulative_dist
FROM customer_spending
ORDER BY total_spent DESC;