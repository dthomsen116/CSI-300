use my_guitar_shop;


SELECT cat.category_name, prod.product_name, prod.list_price

FROM Categories cat

JOIN Products prod ON cat.category_id = prod.category_id

ORDER BY 
cat.category_name ASC,
prod.product_name ASC;


select
    c.last_name,
    c.first_name,
    o.order_date,
    p.product_name,
    oi.item_price,
    oi.discount_amount,
    oi.quantity
from
    customers c
join
    orders o 
	on c.customer_id = o.customer_id
join
    order_items oi 
	on o.order_id = oi.order_id
join
    products p 
	on oi.product_id = p.product_id

order by 
    c.last_name, 
    o.order_date, 
    p.product_name;


SELECT prod1.product_name, prod1.list_price

FROM Products prod1 JOIN Products prod2 
ON prod1.list_price = prod2.list_price 
AND prod1.product_id <> prod2.product_id

ORDER BY 
prod1.product_name;


select
    c.category_name,
    p.product_id
from categories c
left join  products p 
on c.category_id = p.category_id
where
    p.product_id IS NULL;


SELECT COUNT(*) AS order_amount, SUM(tax_amount) AS total_tax_amount
FROM Orders;


select 
	c.email_address,
    	count(distinct o.order_id) as orders,
    	sum((oi.item_price - oi.discount_amount) * oi.quantity) as total
from 
	customers c
join 
	orders o 
on c.customer_id = o.customer_id
join 
	order_items oi 
on o.order_id = oi.order_id
group by
	c.email_address
having
	count(distinct o.order_id) > 1
order by
	total desc;
    
    
 SELECT cust.email_address, COUNT(DISTINCT ordit.product_id) AS distinct_product_count

FROM Customers cust
JOIN Orders ord ON cust.customer_id = ord.customer_id
JOIN Order_Items ordit ON ord.order_id = ordit.order_id

GROUP BY cust.customer_id, cust.email_address
HAVING COUNT(DISTINCT ordit.product_id) > 1 

ORDER BY distinct_product_count ASC;
/* Wasn't required, but not organized numbers bother me lol */


use my_guitar_shop;
select distinct category_name
from categories
		where category_id in (
			select distinct category_id
       			from products)
order by
	category_name;

/*replaces the join command with a select where statement in order to gather the same information rather than a join*/


SELECT cust.email_address, ordit.order_id, SUM(ordit.quantity * ordit.item_price) AS order_total

FROM Customers cust
JOIN Orders ord ON cust.customer_id = ord.customer_id
JOIN Order_Items ordit ON ord.order_id = ordit.order_id

GROUP BY cust.email_address, ordit.order_id

ORDER BY ord.order_id ASC;


/* I was confused about whether or not you wanted the specific order_id that was the largest, or the specific value of the largest order_id, so you get both */
SELECT email_address, MAX(order_id) AS largest_order_id, SUM(order_total) 
AS largest_order_total

FROM (
SELECT cust.email_address, ordit.order_id, SUM(ordit.quantity * ordit.item_price) 
AS order_total

FROM Customers cust
JOIN Orders ord ON cust.customer_id = ord.customer_id
JOIN Order_Items ordit ON ord.order_id = ordit.order_id

GROUP BY cust.email_address, ordit.order_id
) AS sub
GROUP BY email_address;


select 
    order_id,
    order_date,
	'SHIPPED' AS `Shipping Status`
		from orders
			where  ship_date IS NOT NULL
union

/*SHIPPED^^*/ 

select 
    order_id,
    order_date,
	'NOT SHIPPED' AS `Shipping Status`
	from orders
		where ship_date IS NULL

order by 
    order_date;

/*NOT SHIPPED^^*/
