--Explore data

select count(customer_id) from customer
select count(order_id) from cust_order
select count(book_id),count(author_id) from  [dbo].[book_author]
select count(author_id) from [dbo].[author]
select max(order_date) from cust_order
select max(order_id) from cust_order
select max(line_id) from order_line
select * from cust_order

select count(line_id) from order_line 

select * from order_status
SELECT * FROM order_history
order by order_id
SELECT  * FROM address_status
select *from cust_order
select * from [date]

--Test and insert for increamental load_ordersFACT

INSERT INTO cust_order (order_date, customer_id, shipping_method_id, dest_address_id)
VALUES ('2024-03-20 05:47:33.800', 134, 1, 639)

DECLARE @order_id INT;

SET @order_id = SCOPE_IDENTITY()

INSERT INTO order_line (line_id, order_id, book_id, price)
VALUES 
    (15501, @order_id, 8571, 9.12),
    (15502, @order_id, 8571, 9.12),
    (15503, @order_id, 8571, 9.12),
    (15504, @order_id, 8571, 9.12),
    (15505, @order_id, 8571, 9.12);
select * from cust_order 

select * from cust_order
where order_date ='2024-03-20 05:15:33.800'
select * from order_line
where line_id = 7550
--TEST STATUS INCREMENT ON ORDERID= 6
SELECT *
FROM [gravity_books].[dbo].[order_history]
WHERE order_id= 1
update [gravity_books].[dbo].[order_history]
set status_date =  getdate()
where order_id=1 and status_id = 2

