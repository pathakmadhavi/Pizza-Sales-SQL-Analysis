Select * from order_details;

Select * from pizzas;

create Table orders(order_id int not null,
orders_date date not null,
orders_time time not null,
primary key(order_id));

-- Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS Tot_Revenue
FROM
    order_details AS o
        JOIN
    pizzas AS p ON p.pizza_id = o.pizza_id;
    
   --  Identify the highest-priced pizza.
   
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;
   
   -- Identify the most common pizza size ordered.
   
SELECT 
    quantity, COUNT(order_details_id)
FROM
    order_details
GROUP BY quantity;
   
SELECT 
    pizzas.size, COUNT(order_details_id)
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY size
ORDER BY COUNT(order_details_id) DESC;
   
-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(quantity) AS total_orders
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY name
ORDER BY total_orders DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category.

SELECT 
    pizza_types.category, SUM(quantity) AS total_orders
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category
ORDER BY total_orders DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(orders_time), COUNT(order_id) AS total_orders
FROM
    orders
GROUP BY HOUR(orders_time)
ORDER BY total_orders DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(pizza_type_id)
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(tot_quantity), 0) AS avg_pizza_orders_perday
FROM
    (SELECT 
        orders_date, SUM(quantity) AS tot_quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category, round((sum(order_details.quantity * pizzas.price)/(SELECT 
ROUND(SUM(o.quantity * p.price), 2) AS Tot_Revenue
FROM order_details AS o JOIN
pizzas AS p ON p.pizza_id = o.pizza_id) ) * 100, 2) as revenue 
from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category order by revenue desc;

-- Analyze the cumulative revenue generated over time.

select orders_date, sum(revenue) over(order by orders_date) as cum_revenue
from (select orders.orders_date, sum(order_details.quantity * pizzas.price) 
as revenue 
from order_details join pizzas on pizzas.pizza_id = order_details.pizza_id
join orders on order_details.order_id = orders.order_id
group by orders.orders_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category, name, revenue, ranking 
from
(select category, name, revenue, 
rank() over(partition by category order by revenue desc) as ranking
from
(select pizza_types.category, pizza_types.name, 
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name) as sale) as top
where ranking<= 3;




