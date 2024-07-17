create database LatteBrews

use LatteBrews;

/*customer*/
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    date_of_birth DATE,
    loyalty_points INT
);
/*inserting records*/
INSERT INTO Customers (customer_id, first_name, last_name, email, phone_number, address, city, state, zip_code, date_of_birth, loyalty_points)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Seattle', 'WA', '98101', '1985-01-15', 120),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St', 'Seattle', 'WA', '98102', '1990-05-20', 200);

/*Employee*/

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(50),
    salary DECIMAL(10, 2),
    manager_id INT
);

INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, manager_id)
VALUES
(1, 'Alice', 'Brown', 'alice.brown@example.com', '123-555-7890', '2015-03-01', 'Barista', 30000.00, NULL),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '987-555-3210', '2016-06-15', 'Manager', 50000.00, NULL);


/*Coffeetypes*/

CREATE TABLE CoffeeTypes (
    coffee_id INT PRIMARY KEY,
    coffee_name VARCHAR(50),
    description VARCHAR(255),
    origin VARCHAR(50),
    roast_level VARCHAR(20),
    flavor_profile VARCHAR(100),
    caffeine_content INT,
    brew_methods VARCHAR(100)
);

INSERT INTO CoffeeTypes (coffee_id, coffee_name, description, origin, roast_level, flavor_profile, caffeine_content, brew_methods)
VALUES
(1, 'Pike Place Roast', 'Smooth and balanced with rich flavors', 'Latin America', 'Medium', 'Chocolatey, Nutty', 155, 'Drip, French Press'),
(2, 'Espresso Roast', 'Intense and caramelly sweet', 'Latin America', 'Dark', 'Bold, Caramel', 75, 'Espresso, Latte');



/*Coffeeesizes*/

CREATE TABLE CoffeeSizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(20),
    size_oz DECIMAL(5, 2),
    price_multiplier DECIMAL(5, 2)
);

INSERT INTO CoffeeSizes (size_id, size_name, size_oz, price_multiplier)
VALUES
(1, 'Tall', 12.00, 1.00),
(2, 'Grande', 16.00, 1.25),
(3, 'Venti', 20.00, 1.50);


/*Produts*/

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    coffee_id INT,
    category VARCHAR(50),
    base_price DECIMAL(10, 2),
    stock_quantity INT,
    description VARCHAR(255),
    FOREIGN KEY (coffee_id) REFERENCES CoffeeTypes(coffee_id)
);

INSERT INTO Products (product_id, product_name, coffee_id, category, base_price, stock_quantity, description)
VALUES
(1, 'Pike Place Roast - Tall', 1, 'Coffee', 2.45, 100, '12 oz cup of Pike Place Roast'),
(2, 'Espresso Roast - Tall', 2, 'Coffee', 3.25, 80, '12 oz cup of Espresso Roast');


/*Orders*/

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);


INSERT INTO Orders (order_id, customer_id, employee_id, order_date, total_amount, payment_method)
VALUES
(1, 1, 1, '2024-07-10 08:30:00', 5.70, 'Credit Card'),
(2, 2, 2, '2024-07-10 09:00:00', 3.25, 'Cash');

update Orders set total_amount=500.00 where order_id=1
update Orders set total_amount=300.00 where order_id=2

select*from Orders
/*Orederdetails*/

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_each DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

/*INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price_each)
VALUES
(1, 1, 1, 1, 2.45),
(2, 1, 2, 1, 3.25),
(3, 2, 2, 1, 3.25);*/

alter table OrderDetails drop column price_each

alter table OrderDetails add price decimal
alter table OrderDetails add size_id int


select*from OrderDetails
delete from OrderDetails

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price,size_id)
VALUES
(1, 1, 1, 1, 200.00),
(2, 1, 2, 1, 200.00),
(3, 2, 2, 1, 250.00);

/*select * from Products;*/

/*Inserting more data*/

INSERT INTO Customers (customer_id, first_name, last_name, email, phone_number, address, city, state, zip_code, date_of_birth, loyalty_points)
VALUES
(3, 'Emily', 'Clark', 'emily.clark@example.com', '234-567-8901', '789 Pine St', 'Seattle', 'WA', '98103', '1992-07-11', 150),
(4, 'Michael', 'Williams', 'michael.williams@example.com', '345-678-9012', '101 Maple St', 'Seattle', 'WA', '98104', '1988-02-25', 180),
(5, 'Sarah', 'Lee', 'sarah.lee@example.com', '456-789-0123', '202 Oak St', 'Seattle', 'WA', '98105', '1995-11-03', 220);

INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, manager_id)
VALUES
(3, 'Charlie', 'Davis', 'charlie.davis@example.com', '234-555-7891', '2018-07-10', 'Barista', 32000.00, 2),
(4, 'Diana', 'Harris', 'diana.harris@example.com', '345-555-9012', '2019-11-20', 'Shift Supervisor', 36000.00, 2),
(5, 'Edward', 'Martinez', 'edward.martinez@example.com', '456-555-0123', '2020-04-15', 'Barista', 31000.00, 2);

INSERT INTO CoffeeTypes (coffee_id, coffee_name, description, origin, roast_level, flavor_profile, caffeine_content, brew_methods)
VALUES
(3, 'Veranda Blend', 'Mellow and soft with subtle nuances of cocoa', 'Latin America', 'Light', 'Cocoa, Soft Spice', 170, 'Drip, Pour Over'),
(4, 'Sumatra', 'Full-bodied with a smooth mouthfeel and lingering herbal notes', 'Asia/Pacific', 'Dark', 'Herbal, Earthy', 150, 'Drip, French Press'),
(5, 'Komodo Dragon Blend', 'Complex with herbal and spicy notes', 'Asia/Pacific', 'Dark', 'Herbal, Spicy', 160, 'Drip, French Press');


INSERT INTO CoffeeSizes (size_id, size_name, size_oz, price_multiplier)
VALUES
(4, 'Short', 8.00, 0.75),
(5, 'Trenta', 31.00, 2.00);


INSERT INTO Products (product_id, product_name, coffee_id, category, base_price, stock_quantity, description)
VALUES
(3, 'Veranda Blend - Tall', 3, 'Coffee', 2.65, 120, '12 oz cup of Veranda Blend'),
(4, 'Sumatra - Tall', 4, 'Coffee', 2.85, 90, '12 oz cup of Sumatra'),
(5, 'Komodo Dragon Blend - Tall', 5, 'Coffee', 2.95, 70, '12 oz cup of Komodo Dragon Blend'),
(6, 'Pike Place Roast - Grande', 1, 'Coffee', 3.05, 100, '16 oz cup of Pike Place Roast'),
(7, 'Espresso Roast - Grande', 2, 'Coffee', 3.85, 80, '16 oz cup of Espresso Roast');


INSERT INTO Orders (order_id, customer_id, employee_id, order_date, total_amount, payment_method)
VALUES
(3, 3, 3, '2024-07-11 10:00:00', 5.30, 'Credit Card'),
(4, 4, 4, '2024-07-11 10:30:00', 2.85, 'Debit Card'),
(5, 5, 5, '2024-07-11 11:00:00', 3.85, 'Cash');
update Orders set total_amount=500.00 where order_id=3
update Orders set total_amount=285.00 where order_id=4
update Orders set total_amount=300.00 where order_id=5

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price)
VALUES
(4, 3, 3, 2, 200.00),
(5, 4, 4, 1, 200.00),
(6, 5, 7, 1, 200.00);



drop table CoffeeSizes

CREATE TABLE CoffeeSizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(20),
    size_oz DECIMAL(5, 2),
    price DECIMAL(10, 2)
);

INSERT INTO CoffeeSizes (size_id, size_name, size_oz, price)
VALUES
(1, 'Tall', 12.00, 200.00),
(2, 'Grande', 16.00, 250.00),
(3, 'Venti', 20.00, 300.00),
(4, 'Short', 8.00, 150.00),
(5, 'Trenta', 31.00, 350.00);

/*test case*/
select*from Orders where order_id<6
select size_name from CoffeeSizes where price<200


/*EXAMPLE QUERIES IN LATTE BREWS */

/*1) SHOW ALL ENTRIES OF TABLE*/

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM CoffeeSizes;
SELECT * FROM CoffeeTypes;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM Products;

/*2) Join Orders with Customers and Employees to Show Order Details*/

SELECT o.order_id, o.order_date, c.first_name AS customer_first_name, c.last_name AS customer_last_name,
       e.first_name AS employee_first_name, e.last_name AS employee_last_name, o.total_amount, o.payment_method
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Employees e ON o.employee_id = e.employee_id;



/* Adding more data to perform queries*/

INSERT INTO Customers (customer_id, first_name, last_name, email, phone_number, address, city, state, zip_code, date_of_birth, loyalty_points)
VALUES
(6, 'Rahul', 'Sharma', 'rahul.sharma@example.com', '9876543210', '123 MG Road', 'Bangalore', 'KA', '560001', '1985-01-15', 120),
(7, 'Priya', 'Verma', 'priya.verma@example.com', '8765432109', '456 Park Street', 'Mumbai', 'MH', '400001', '1990-03-22', 200),
(8, 'Vikram', 'Singh', 'vikram.singh@example.com', '7654321098', '789 Lake View', 'Delhi', 'DL', '110001', '1987-05-30', 150),
(9, 'Neha', 'Patel', 'neha.patel@example.com', '6543210987', '321 Green Park', 'Ahmedabad', 'GJ', '380001', '1992-07-15', 180),
(10, 'Amit', 'Kumar', 'amit.kumar@example.com', '5432109876', '654 Rose Avenue', 'Chennai', 'TN', '600001', '1988-10-10', 160),
(11, 'Sita', 'Reddy', 'sita.reddy@example.com', '4321098765', '987 Sunshine Road', 'Hyderabad', 'TS', '500001', '1991-12-25', 220);


INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_title, salary, manager_id)
VALUES
(6, 'Anjali', 'Nair', 'anjali.nair@example.com', '9198765432', '2015-05-15', 'Manager', 60000.00, NULL),
(7, 'Ravi', 'Mehta', 'ravi.mehta@example.com', '9197654321', '2017-09-23', 'Barista', 30000.00, 1),
(8, 'Sunita', 'Khan', 'sunita.khan@example.com', '9196543210', '2018-03-01', 'Cashier', 25000.00, 1),
(9, 'Arjun', 'Desai', 'arjun.desai@example.com', '9195432109', '2019-07-15', 'Barista', 28000.00, 1),
(10, 'Pooja', 'Kapoor', 'pooja.kapoor@example.com', '9194321098', '2020-10-10', 'Barista', 30000.00, 1),
(11, 'Karan', 'Rao', 'karan.rao@example.com', '9193210987', '2021-01-20', 'Barista', 32000.00, 1);

INSERT INTO CoffeeTypes (coffee_id, coffee_name, description, origin, roast_level, flavor_profile, caffeine_content, brew_methods)
VALUES
(6, 'Decaf Pike Place Roast', 'Smooth and well-balanced, decaffeinated', 'Latin America', 'Medium', 'Chocolate, Nuts', 5, 'Drip, Pour Over');

INSERT INTO Orders (order_id, customer_id, employee_id, order_date, total_amount, payment_method)
VALUES
(6, 6, 1, '2024-07-11 08:30:00', 400.00, 'Credit Card'),
(7, 7, 3, '2024-07-11 09:00:00', 200.00, 'Debit Card'),
(8, 8, 3, '2024-07-11 10:00:00', 500.00, 'Credit Card'),
(9, 9, 4, '2024-07-12 11:00:00', 300.00, 'Cash'),
(10,10, 2, '2024-07-12 12:30:00', 450.00, 'Credit Card'),
(11, 11, 6, '2024-07-12 13:45:00', 600.00, 'Debit Card');


INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price, size_id)
VALUES
(1, 1, 1, 1, 200.00, 1),
(2, 2, 2, 1, 200.00, 1),
(3, 3, 2, 1, 200.00, 1),
(4, 4, 3, 2, 250.00, 2),
(5, 5, 4, 1, 200.00, 1),
(6, 6, 2, 1, 250.00, 2),
(7, 7, 1, 2, 300.00, 3),
(8, 8, 3, 2, 300.00, 3),
(9, 9, 4, 1, 200.00, 1),
(10,10, 5, 2, 350.00, 5),
(11,11, 5, 2, 350.00, 5);




/*3)Detailed Order Information Including Coffee Size Prices in Rupees*/

SELECT o.order_id, o.order_date, c.first_name, c.last_name, p.product_name, cs.size_name, od.quantity, od.price, 
       (od.quantity * od.price) AS total_price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN CoffeeSizes cs ON od.size_id = cs.size_id;


/*4)Total Revenue from Each Coffee Type by Size in Rupees*/

SELECT ct.coffee_name, cs.size_name, SUM(od.quantity * od.price) AS total_revenue
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN CoffeeTypes ct ON p.coffee_id = ct.coffee_id
JOIN CoffeeSizes cs ON od.size_id = cs.size_id
GROUP BY ct.coffee_name, cs.size_name
ORDER BY total_revenue DESC;


/*5)Most Frequently Purchased Coffee and Size in Rupees*/

SELECT p.product_name, cs.size_name, SUM(od.quantity) AS total_quantity
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN CoffeeSizes cs ON od.size_id = cs.size_id
GROUP BY p.product_name, cs.size_name
ORDER BY total_quantity DESC


/*6)List of Customers with Total Loyalty Points*/

SELECT customer_id, first_name, last_name, SUM(loyalty_points) AS total_loyalty_points
FROM Customers
GROUP BY customer_id, first_name, last_name;


/*7)List of Employees with Their Total Sales (Total Amount of Orders They Handled)*/

SELECT e.employee_id, e.first_name, e.last_name, SUM(o.total_amount) AS total_sales
FROM Employees e
JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;


/*8)Average Order Amount*/
SELECT AVG(total_amount) AS average_order_amount
FROM Orders;


/*9)Total Number of Orders Placed by Each Customer*/
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;


/*10) Monthly Sales Report (Total Revenue by Month)*/

SELECT 
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(od.quantity * od.price) AS total_revenue
FROM 
    Orders o
JOIN 
    OrderDetails od ON o.order_id = od.order_id
GROUP BY 
    YEAR(o.order_date), MONTH(o.order_date)
ORDER BY 
    year, month;


/*11) Inventory Check (Products with Low Stock)*/

SELECT product_id, product_name, stock_quantity
FROM Products
WHERE stock_quantity < 100
ORDER BY stock_quantity ASC;
select*from Products

/*12)List All Products with Their Coffee Type and Category*/

SELECT p.product_name, ct.coffee_name, p.category
FROM Products p
JOIN CoffeeTypes ct ON p.coffee_id = ct.coffee_id;


/*13)Most Popular Coffee Type (Based on Total Quantity Sold)*/

SELECT ct.coffee_name, SUM(od.quantity) AS total_quantity_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN CoffeeTypes ct ON p.coffee_id = ct.coffee_id
GROUP BY ct.coffee_name
ORDER BY total_quantity_sold DESC;


/*14)List All Orders with Their Total Amount in Rupees*/

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

/*15)Customer Purchase History*/

SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, SUM(od.quantity * od.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
ORDER BY o.order_date;
