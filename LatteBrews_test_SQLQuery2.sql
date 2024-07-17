/*EXAMPLE QUERIES IN LATTE BREWS */
/*using database in another sql query file*/

use LatteBrews

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

/* neglect if already inserted more data 

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

*/

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
