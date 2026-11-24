CREATE INDEX idx_customer 
ON Sales(Customer_ID);

CREATE INDEX idx_category 
ON Sales(Category);

CREATE INDEX idx_sale_date 
ON Sales(Sale_Date);

CREATE INDEX idx_city 
ON Sales(City);

CREATE INDEX idx_customer_category_date 
ON Sales(Customer_ID, Category, Sale_Date);
