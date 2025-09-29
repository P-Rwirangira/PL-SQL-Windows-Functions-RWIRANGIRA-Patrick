-- AutoForge Motors: Cars Table Creation

DROP TABLE IF EXISTS cars;

CREATE TABLE cars (
    car_id SERIAL PRIMARY KEY,
    model_name VARCHAR(50) NOT NULL,
    category VARCHAR(30),
    base_price DECIMAL(10,2)
);