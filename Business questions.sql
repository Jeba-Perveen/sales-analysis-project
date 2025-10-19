-- creating database
create database sales_analysis
--************************************************************************

-- Droping category table if exists
drop table if exists dbo.Category
-- creating category table
create table category(
		category_id int primary key,
		category_name  nvarchar(50)
		)
-- inserting data into category table using bulk insert
bulk insert category
from 'C:\Users\jebap\OneDrive\Desktop\categories.csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from category;
--****************************************************************************


-- Droing customers table if exists
drop table if exists dbo.Customers
-- creating customers table
create table customers(
			customer_id int primary key,
			f_name nvarchar(20),
			l_name nvarchar(20),
			email nvarchar(40),
			address nvarchar(40)
			)
-- inserting data into customers table using bulk insert method
bulk insert customers
from 'C:\Users\jebap\OneDrive\Desktop\customers (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from customers;
--*****************************************************************************


--Droping order_items table if exists
drop table if exists dbo.Order_items
-- creating table order_items
create table order_items(
			order_item_id  int primary key,
			order_id int,
			product_id int,
			quantity int,
			price_per_unit int,
			total_price int)

-- inserting data into order_items table using bulk insert method
bulk insert order_items
from 'C:\Users\jebap\OneDrive\Desktop\order_items (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from order_items;
--*****************************************************************************


--Droping orders table if exists
drop table if exists dbo.Orders
-- creating table orders
create table orders(
		order_id int primary key,
		order_date nvarchar(20),
		customer_id	 int,
		order_status nvarchar(40),
		product_id int,
		seller_id int)

-- inserting data into order table using bulk insert method
bulk insert orders
from 'C:\Users\jebap\OneDrive\Desktop\orders (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from orders;
--****************************************************************************


-- drop payment table if exists
drop table if exists dbo.inventory
-- create table payment
create table inventory(
	  inventory_id int primary key,
	  product_id int,
	  stock_remaining int,
	  warehouse_id int,
	  restock_date nvarchar(20))

-- inserting data into inventory table using bulk insert method
bulk insert inventory
from 'C:\Users\jebap\OneDrive\Desktop\inventory (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock); 
select * from inventory;
--*****************************************************************************


-- drop table payments if exists
drop table if exists dbo.payment;
-- creating table payments 
create table payments(
		payment_id int primary key,
		payment_date nvarchar(30),
		payment_amount int,
		payment_mode nvarchar(30),
		payment_status	nvarchar(40),
		order_id int)

--inserting data into payments table using bulk insert method
bulk insert payments
from 'C:\Users\jebap\OneDrive\Desktop\payments.csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from payments
--*************************************************************************


--drop table products if exists
drop table if exists Products 
-- create table products
create table products(
		product_id int primary key,
		product_name nvarchar(50),
		price int,
		cogs int,
		category_id	 int,
		seller_id int)

-- inserting data into  products table using bulk insert method
bulk insert products
from 'C:\Users\jebap\OneDrive\Desktop\products (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from products;
--*************************************************************************


-- drop table sellers if exists
drop table if exists dbo.sellers
--create table sellers
create table sellers(
		seller_id int primary key,
		seller_name nvarchar(50),
		brand_type nvarchar(50));

-- inserting data into sellers table using bulk insert method
bulk insert sellers
from 'C:\Users\jebap\OneDrive\Desktop\sellers (1).csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		tablock);
select * from sellers
--**************************************************************************


--drop table shipping if exists
drop table  if exists dbo.shipping 
--create table shipping
create table shipping(
		shipping_id	int primary key,
		order_id int,
		delivery_status	nvarchar(50),
		shipping_date nvarchar(20),
		return_date nvarchar(20))

-- inserting data into shipping table using bulk insert method
bulk insert shipping
from 'C:\Users\jebap\OneDrive\Desktop\shipping.csv'
with (
		fieldterminator = ',',		
		firstrow = 2,
		keepnulls,
		tablock);
select * from shipping;
--******************************************************************************


--*****************************************************************
-- Data exploration and Cleaning
--*****************************************************************

-- changing the data type of order_date from nvarchar to date in orders table
alter table orders
alter column order_date date;

-- changing the data type of shipping_date from nvarchar to date in shipping table
alter table shipping
alter column shipping_date date;

-- changing the data type of return_date from nvarchar to date in shipping table
alter table shipping
alter column return_date date;

-- changing the data type of restock_date from nvarchar to date in inventory table
alter table inventory
alter column restock_date date;

-- changing the data type of payment_date from nvarchar to date in payments table
alter table payments
alter column payment_date date;

--extracting city name from customer table
alter table customers
add city nvarchar(30);

update customers
set city = ltrim(rtrim(
		substring( address, charindex(',',address)+1,
							charindex(',',address,charindex(',',address)+1)-
							charindex(',',address)-1)
				))



--*********************************************
-- Advance bussiness problems.
--*********************************************
/*
1.Top selling products
  Query the top 10 products by total sales value.
  challeng : Include product name,total quantity sold and total sales value.
  */
select top 10 p.product_name,
	   count(o.quantity) as total_quantity ,
	   round(sum(total_price),2) as total_sales
from 
products p join order_items o
on p.product_id = o.product_id
group by p.product_name
order by total_sales desc


/*
2.Revenue by category
  Calculate total revenue generated by each product category
  Challenge : Include the percentage contribution of each category to total revenue.
*/
select p.product_id,
	   p.product_name,
	   sum(o.total_price) as total_revenue,
	   round((sum(o.total_price) *100.0 /(select sum(total_price) from order_items)),2)as percent_conti
from products p 
join order_items o on
p.product_id = o.product_id
group by p.product_id,
	   p.product_name;


/*
3.Average order value (AOV)
compute the average order value for each customer.
challenge : Include only customers with more than 5 orders
*/
select c.customer_id,
	   concat(c.f_name, ' ', c.l_name) as customer_name,
	   count(o.order_id) as total_order,
	   sum(oi.total_price)/count(o.order_id) as AOV 
from customers c 
join orders o
on o.customer_id = c.customer_id
join order_items oi 
on oi.order_id = o.order_id
group by c.customer_id,
	   concat(c.f_name, ' ', c.l_name)


/*
4.Monthly sales trend
Query monthly total sales over the past year.
challenge : Display the sales trend,group by month,return current month sale, last month sale.
*/
select year_month,
	   total_amount as current_month_sale,
	   lag(total_amount) over(order by year_month) as previous_month_sales
from(
	select format(order_date , 'yyyy-MM') as year_month,
		   sum(oi.total_price) as total_amount
	from order_items oi
	join orders o
	on o.order_id = oi.order_id
	group by format(order_date , 'yyyy-MM')
)t


/*
5.Customer with no purchases
find the customers who have registered but never placed an order.
challenge : list customer details and the time since their registration
*/
select customer_id,
	   concat(f_name,' ',l_name) as customer_name
from customers 
where customer_id not in 
				(select distinct customer_id from orders)

select * from customers
/*
6.Best-selling category by state
identify the best selling product category for each city.
challenge : include the total sales for that category within each state.
*/
select city,
	   category_name,
	   total_sale
from(
select c.city,
	   cat.category_name,
	   sum(oi.total_price) as total_sale,
	   rank() over(partition by c.city order by sum(oi.total_price) desc) as rnk
from customers c
join orders o 
on o.customer_id = c.customer_id
join order_items oi
on oi.order_id = o.order_id
join products p 
on p.product_id = oi.product_id
join category cat
on cat.category_id = p.category_id
group by c.city,
	   cat.category_name)t
where rnk = 1
order by total_sale desc



/*
7.Customer lifetime value (CLTV)
calculate total value of orders placed by each customer over their lifetime.
challenge : rank customers based on their CLTV
*/
select c.customer_id,
       concat(f_name , ' ' ,l_name) as customer_name,
	   sum(oi.total_price) as CLTV,
	   dense_rank() over(order by sum(oi.total_price) desc) as rnk
from customers c
join orders o
on o.customer_id = c.customer_id
join order_items oi
on oi.order_id = o.order_id
group by c.customer_id,
       concat(f_name , ' ' ,l_name) 


/*
8.Inventory stock alerts
query products with stock level below a certain threshold
challenge : Include last restock date and warehouse information.
*/
select i.inventory_id ,
	   p.product_id,
	   i.warehouse_id,
	   p.product_name,
	   max(i.restock_date) as last_restock
from inventory i
join products p
on p.product_id = i.product_id
group by i.inventory_id ,
	   p.product_id,
	   i.warehouse_id,
	   p.product_name

/*
9.Shipping delays
identify orders where shipping date is later than 2 days after the order date.
challenge : include customer,order details and delivery providers.
*/
select c.customer_id,
       o.order_id,
	   concat(c.f_name , ' ' , c.l_name) as customer_name,
	   o.order_date,	   
	   s.shipping_date,
	   o.order_status,
	   s.delivery_status,
	   datediff(day,o.order_date ,s.shipping_date) as days_diff
from orders o
join customers c
on c.customer_id = o.customer_id
join shipping s
on s.order_id = o.order_id
where datediff(day,o.order_date ,s.shipping_date)>2


/*
10.payment success rate
calculate the percentage of successful payments across all orders.
challenge: include breakdowns by payment status
*/
select  payment_status ,
		count(*) as total_count,
		round(count(*)*100.0/(select count(*) from payments) ,2)as percent_conti
from payments
group by payment_status;


/*
11.Top performing sellers
find the top 5 sellers based on total_sales value.
challenge : include order status (delivered and processing).
*/
with top_sellers as (
	select top 5 s.seller_id,
				 s.seller_name,
				 sum(oi.total_price) as total_sales			 
	from sellers s
	join orders o 
	on o.seller_id = s.seller_id
	join order_items oi 
	on oi.order_id = o.order_id
	group by s.seller_id,
				 s.seller_name	),
seller_report as (
	select o.seller_id,
		   t.seller_name,
		   o.order_status,
		   count(*) as total_orders
	from orders o 
	join top_sellers t
	on o.seller_id = t.seller_id
	where o.order_status not in('In Transit','Shipped')
	group by o.seller_id,
			   t.seller_name,
			   o.order_status)

select seller_id,
	   seller_name ,
	   sum(case when order_status = 'Delivered' then total_orders else 0 end) as completed_orders,
	   sum(case when order_status = 'Processing' then total_orders else 0 end) as processed_orders,
	   sum(total_orders) as total_orders	   
from seller_report
group by seller_id,
	   seller_name





