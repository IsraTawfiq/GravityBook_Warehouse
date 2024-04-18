use [gravity_books]
-- BOOK
SELECT b.book_id, 
       b.title,
	   b.isbn13,
       b.num_pages,
	   b.publication_date,
	   l.language_id, 
	   l.language_code,
	   l.language_name,
	   p.publisher_id, 
       p.publisher_name
FROM   book  b LEFT  JOIN  book_language l ON b.language_id = l.language_id
      LEFT  JOIN publisher p ON b.publisher_id = p.publisher_id


--Dim address_customer
SELECT 
    customer.customer_id,
    address.address_id,
    address.street_number,
    address.street_name,
    address.city,
    address_status.status_id, 
    address_status.address_status,
    country.country_id,
    country.country_name
FROM     
    customer
LEFT JOIN
    customer_address ON customer.customer_id = customer_address.customer_id
right JOIN
    address ON customer_address.address_id = address.address_id
LEFT JOIN
    country ON address.country_id = country.country_id
LEFT JOIN
    address_status ON customer_address.status_id = address_status.status_id

--CUST LOOKUP_NK_SK
USE [GravityBooksDWH]
SELECT customer_id_SK, 
	  customer_id_NK
FROM [dbo].[DimCustomer]
WHERE Is_Current = 1
--book LOOKUP_NK_SK
USE [GravityBooksDWH]
select book_id_SK,		
	book_id_NK
FROM [dbo].[DIMBOOK]
WHERE Is_Current = 1
--author LOOKUP_NK_SK
select author_id_SK ,author_id_NK
from [dbo].[DIMAuthor]
WHERE Is_Current = 1 -- AND SOURCE_CODE=
---method LOOKUP_NK_SK
select shipping_method_id_SK, method_id_NK
from [dbo].[DIMshippingmethod]
WHERE Is_Current = 1
--status lookup
SELECT  status_order_id_SK,
	status_id_NK
  FROM [DIMstatus]
  WHERE Is_Current = 1

--lookup date
SELECT  DateSK, [Date]
FROM    [dbo].[DimDate]
datesk int , date date notnull
--lookup Time
SELECT  TimeSK, [Time]
FROM    [dbo].[DimTime]

                                     --FACT BOOK ORDERS 
USE [gravity_books]
SELECT c.order_id, convert(date,c.order_date) as order_Date,CONVERT(TIME(0), c.order_date) AS order_Time
, c.customer_id,
c.shipping_method_id, c.dest_address_id,l.line_id, l.book_id, l.price
FROM      gravity_books.dbo.cust_order c JOIN
              gravity_books.dbo.order_line l   ON c.order_id = l.order_id

where l.line_id> ? --LAST_LOAD_ORDERLINEID
and c.order_date>= ? -- last_load_order_date
AND c.order_date < ? --SYS starttime
order by l.line_id
                               --ctrlflow_fact_orders
---get last_load_date
select LAST_LOAD_DATE from Meta_CTRL_load where source_table = 'Book_Orders'

--update last_load_date
  UPDATE Meta_CTRL_load

   SET LAST_LOAD_DATE= ? --start_time
   ,LAST_LOAD_lineId_NK =? --get_max

  where source_table = 'Book_Orders'

  --get_max-line_id
select max (line_id_NK) as update_LAST_LOAD_lineId
from [GravityBooksDWH].[dbo].[Fact_book_order]


                                      --fact_status
SELECT 
    h.order_id,
    MAX(h.status_id) as status_id,
    MAX(CASE WHEN [status_id] = 1 THEN CONVERT(date, [status_date]) END) AS 'order received',
    MAX(CASE WHEN [status_id] = 2 THEN CONVERT(date, [status_date]) END) AS 'pending delivery',
    MAX(CASE WHEN [status_id] = 3 THEN CONVERT(date, [status_date]) END) AS 'delivery in progress',
    MAX(CASE WHEN [status_id] = 4 THEN CONVERT(date, [status_date]) END) AS 'delivered',
    MAX(CASE WHEN [status_id] = 5 THEN CONVERT(date, [status_date]) END) AS 'canceled',
    MAX(CASE WHEN [status_id] = 6 THEN CONVERT(date, [status_date]) END) AS 'returned'
FROM 
    gravity_books.[dbo].[order_history] AS h
WHERE [status_date] >= ? -- User variable: st_last_load_date 
AND [status_date] < ?  -- System variable: start_time

GROUP BY 
    h.order_id
ORDER BY 
    (h.order_id)

                                 ---meta_ctrl_status_fact
select LAST_LOAD_DATE from [dbo].[ctrl_status] where source_table = 'Order_Processing'


select max (order_id_NK) as update_LAST_LOAD_order_id
  FROM [GravityBooksDWH].[dbo].[Accumulative_Order_Processing]
 
   
	 UPDATE ctrl_status

   SET LAST_LOAD_DATE = ? --start_time
   ,last_load_order_id_NK =? --get_max

  where source_table = 'Order_Processing'

