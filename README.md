# sales-analysis-project
SQL-based sales analysis database with advanced analytics

##  Project Overview
This project implements a comprehensive sales analysis database system using SQL Server. It provides insights into sales performance, customer behavior, inventory management, and business metrics through advanced SQL queries and data analysis.

##  Business Objectives
- Analyze sales trends and product performance
- Track customer lifetime value and purchasing patterns
- Monitor inventory levels and stock management
- Evaluate seller performance and revenue distribution
- Identify operational inefficiencies in shipping and payments

##  Database Schema

### Tables Structure

1. **Category** - Product categories
   - `category_id` (PK)
   - `category_name`

2. **Customers** - Customer information
   - `customer_id` (PK)
   - `f_name`, `l_name`
   - `email`, `address`
   - `city` (derived)

3. **Products** - Product catalog
   - `product_id` (PK)
   - `product_name`, `price`, `cogs`
   - `category_id` (FK)
   - `seller_id` (FK)

4. **Orders** - Order transactions
   - `order_id` (PK)
   - `order_date`, `order_status`
   - `customer_id` (FK)
   - `product_id` (FK)
   - `seller_id` (FK)

5. **Order_Items** - Line items for orders
   - `order_item_id` (PK)
   - `order_id` (FK)
   - `product_id` (FK)
   - `quantity`, `price_per_unit`, `total_price`

6. **Inventory** - Stock management
   - `inventory_id` (PK)
   - `product_id` (FK)
   - `stock_remaining`, `warehouse_id`
   - `restock_date`

7. **Payments** - Payment transactions
   - `payment_id` (PK)
   - `payment_date`, `payment_amount`
   - `payment_mode`, `payment_status`
   - `order_id` (FK)

8. **Sellers** - Seller information
   - `seller_id` (PK)
   - `seller_name`, `brand_type`

9. **Shipping** - Delivery tracking
   - `shipping_id` (PK)
   - `order_id` (FK)
   - `delivery_status`, `shipping_date`, `return_date`

##  Technical Implementation

### Data Loading
- Utilized **BULK INSERT** operations for efficient data loading from CSV files
- Implemented proper field terminators and handled first-row headers
- Applied `TABLOCK` for optimized performance

### Data Transformation
- Converted date columns from `NVARCHAR` to `DATE` data type
- Extracted city names from address fields using string manipulation functions
- Applied data cleaning and standardization techniques

##  Advanced Business Analytics

### 1. Top Selling Products
Identifies the top 10 products by total sales value, including quantity sold and revenue generated.

### 2. Revenue by Category
Calculates total revenue per product category with percentage contribution to overall revenue.

### 3. Average Order Value (AOV)
Computes AOV for customers with more than 5 orders to identify high-value customers.

### 4. Monthly Sales Trend
Tracks monthly sales performance with month-over-month comparison using window functions.

### 5. Customer Acquisition Analysis
Identifies registered customers who haven't made purchases for targeted marketing campaigns.

### 6. Best-Selling Category by City
Determines the top-performing product category in each city using ranking functions.

### 7. Customer Lifetime Value (CLTV)
Ranks customers based on their total purchase value for loyalty program optimization.

### 8. Inventory Stock Alerts
Monitors products with low stock levels and tracks last restock dates by warehouse.

### 9. Shipping Delays Analysis
Identifies orders with shipping delays exceeding 2 days for logistics improvement.

### 10. Payment Success Rate
Calculates payment success rates with breakdowns by payment status.

### 11. Top Performing Sellers
Ranks top 5 sellers by sales value with order status breakdown (delivered vs processing).

##  Key SQL Techniques Used

- **Aggregate Functions**: SUM, COUNT, AVG for data summarization
- **Window Functions**: RANK, DENSE_RANK, LAG for advanced analytics
- **Common Table Expressions (CTEs)**: For complex query organization
- **Joins**: Multiple table joins for comprehensive data retrieval
- **Date Functions**: DATEDIFF, FORMAT for temporal analysis
- **String Functions**: SUBSTRING, CHARINDEX, LTRIM, RTRIM for data extraction
- **Subqueries**: Nested queries for percentage calculations
- **CASE Statements**: Conditional logic for data transformation

## 📊 Key Performance Indicators (KPIs)

- Total Revenue & Revenue Growth
- Average Order Value (AOV)
- Customer Lifetime Value (CLTV)
- Payment Success Rate
- Shipping Performance Metrics
- Inventory Turnover
- Seller Performance Rankings
- Category-wise Revenue Distribution

##  Getting Started

### Prerequisites
- SQL Server 2016 or higher
- CSV data files for all tables

### Setup Instructions

1. **Create Database**
   ```sql
   CREATE DATABASE sales_analysis
   ```

2. **Update File Paths**
   - Modify the file paths in BULK INSERT statements to match your local directory

3. **Execute Scripts**
   - Run the table creation scripts
   - Execute BULK INSERT operations
   - Apply data transformation queries

4. **Run Analysis Queries**
   - Execute business analytics queries for insights

##  Project Structure
```
sales-analysis-project/
├── sales project.sql          # Main SQL script
├── data/                      # CSV data files
│   ├── categories.csv
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── inventory.csv
│   ├── payments.csv
│   ├── sellers.csv
│   └── shipping.csv
└── README.md
```

##  Use Cases

- **E-commerce Analytics**: Track product performance and customer behavior
- **Inventory Management**: Monitor stock levels and restock patterns
- **Financial Analysis**: Payment processing and revenue tracking
- **Logistics Optimization**: Identify and reduce shipping delays
- **Seller Management**: Evaluate and rank seller performance
- **Customer Segmentation**: Identify high-value customers and inactive users

##  Insights Delivered

- Product and category performance metrics
- Customer purchasing patterns and loyalty indicators
- Inventory optimization opportunities
- Operational bottlenecks in shipping and payments
- Seller productivity and performance rankings
- Geographic sales distribution by city




##  Author
Jeba-perveen

##  Acknowledgments
- SQL Server documentation
- Data analysis best practices
- E-commerce analytics methodologies



