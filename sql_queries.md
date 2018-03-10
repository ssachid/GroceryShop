
### SQL query to get the details(id, product_name and total number) of a product with id 5 purchased by the user with id 1

```sql
SELECT users.id AS customer_id, 
users.first_name AS customer_first_name, 
products.id AS product_id, 
products.name AS product_name, 
SUM(products.quantity) AS number_purchased  
FROM users INNER JOIN orders 
ON users.id = orders.user_id 
INNER JOIN order_products 
ON orders.id = order_products.order_id 
INNER JOIN products ON order_products.product_id = products.id 
WHERE orders.user_id = 1 AND products.id = 5 
GROUP BY users.id, products.id;

 customer_id | customer_first_name | product_id |    product_name     | number_purchased
-------------+---------------------+------------+---------------------+------------------
           1 | Shambhavi           |          5 | Anastasia Considine |             12.0
```

### SQL query to get all the products purchased by the user with id 1

```sql
SELECT users.id AS customer_id, 
users.first_name AS customer_first_name, 
products.id AS product_id, 
products.name AS product_name, 
SUM(products.quantity) AS number_purchased  
FROM users INNER JOIN orders 
ON users.id = orders.user_id 
INNER JOIN order_products 
ON orders.id = order_products.order_id 
INNER JOIN products
ON order_products.product_id = products.id 
WHERE orders.user_id = 1 
GROUP BY users.id, products.id;

 customer_id | customer_first_name | product_id |    product_name     | number_purchased
-------------+---------------------+------------+---------------------+------------------
           1 | Shambhavi           |          5 | Anastasia Considine |             12.0
           1 | Shambhavi           |          3 | Trace Lebsack       |             28.0
           1 | Shambhavi           |          2 | Kiel Funk           |              2.0
           1 | Shambhavi           |          4 | Eulalia Mueller     |              2.0
```

