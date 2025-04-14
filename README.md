# Pizza-Sales-SQL-Analysis
SQL project analyzing pizza sales trends, revenue, and customer preferences using a one-year dataset.
# 🍕 Pizza Sales SQL Analysis

This project analyzes one year of pizza sales data to uncover trends, customer preferences, and revenue insights using SQL.

## 📊 Project Overview

- **Time Period**: Jan 2015 – Dec 2015
- **Total Orders**: 48,000+
- **Pizzas Sold**: 91,000+
- **Revenue**: $1.7M+
- **Tools Used**: MySQL, Excel

## 🧩 Key Business Questions Answered

- What are the monthly and yearly sales trends?
- Which pizza categories and types are most popular?
- How do sizes and time of day impact sales?
- What is the category-wise revenue contribution?

## 📂 Files Included

- `pizzahub_project.sql`: SQL queries for the entire analysis
- `Pizza_Sales_Analysis.pdf`: A PDF summary of the analysis and key findings

## 📌 SQL Highlights

Some of the questions covered:
- Total number of orders and revenue
- Most ordered pizza types
- Distribution by category, size, and hour
- Top revenue contributors
- Cumulative revenue over time

## 📈 Sample Query

```sql
-- Retrieve total revenue generated
SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM orders;
