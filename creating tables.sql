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


