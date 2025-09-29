-- CREATE TABLE FOR SALES
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    car_id INT REFERENCES cars(car_id),
    sale_date DATE NOT NULL,
    quantity INT DEFAULT 1,
    total_amount DECIMAL(12,2) NOT NULL
);