-- =============================================
-- AutoForge Motors: Ranking Function Queries
Top 5 car models per district per quarter
WITH sales_agg AS (
    SELECT 
        c.region AS district,
        EXTRACT(QUARTER FROM s.sale_date) AS quarter,
        ca.model_name,
        SUM(s.quantity) AS total_units
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    JOIN cars ca ON s.car_id = ca.car_id
    GROUP BY c.region, quarter, ca.model_name
),
ranked AS (
    SELECT 
        district,
        quarter,
        model_name,
        total_units,
        RANK() OVER (PARTITION BY district, quarter ORDER BY total_units DESC) AS model_rank
    FROM sales_agg
)
SELECT * FROM ranked
WHERE model_rank <= 5
ORDER BY district, quarter, model_rank;

-- 1.2 DENSE_RANK example (Huye, Q2)
WITH huye_q2 AS (
    SELECT 
        ca.model_name,
        SUM(s.quantity) AS units
    FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
    JOIN cars ca ON s.car_id = ca.car_id
    WHERE c.region = 'Huye' AND EXTRACT(QUARTER FROM s.sale_date) = 2
    GROUP BY ca.model_name
)
SELECT 
    model_name,
    units,
    DENSE_RANK() OVER (ORDER BY units DESC) AS dense_rank_val
FROM huye_q2
ORDER BY units DESC;