# ☕ Cafe Sales Data Cleaning & Reconstruction (MySQL)

## 📌 Business Overview
This project performs an **End-to-End Data Cleaning** pipeline on a transactional café dataset (`dirty_cafe_sales.csv`) comprising ~10,000 records. The raw dataset contained multiple data quality issues, including error strings (`'UNKNOWN'`, `'ERROR'`), missing values, and mathematical inconsistencies between unit prices, quantities, and total spending.

## 🎯 Key Objectives
1. **Schema Standardization**: Define and enforce a structured MySQL table schema using appropriate `ENUM` and `DATE` data types.
2. **Mathematical Reconstruction**: Restore missing transaction values using algebraic logic ($\text{Total} = \text{Quantity} \times \text{Price}$) and catalog price rules.
3. **Audit & Validation**: Conduct quality assurance checks to ensure 0% mathematical error and 100% data integrity before deployment to production or BI dashboards.

## 🛠️ Tools & Technologies
- **Database**: MySQL Server
- **Data Processing & Export**: Python (`pandas`, `mysql-connector`) / MySQL CLI
- **Version Control**: Git & GitHub

## 🧹 Cleaning Workflow Highlights
- **ENUM & Categorical Handling**: Replaced invalid placeholder strings (`'UNKNOWN'`, `'ERROR'`) with native `NULL` values to preserve schema constraints without dropping rows.
- **Deductive Price Mapping**: Reconstructed unit prices and item names using the fixed menu price catalog:
  - `Cookie` = $1.00 | `Coffee` = $2.00 | `Tea` = $1.50
  - `Cake` / `Juice` = $3.00 | `Smoothie` / `Sandwich` = $4.00 | `Salad` = $5.00
- **Automated Math Correction**: Calculated missing values dynamically using algebraic formulas: `price_per_unit` = `total_spent`/`quantity`.  

## 📊 Summary Comparison
| Metric | Raw Dataset (`dirty_cafe_sales.csv`) | Clean Dataset (`cafe_sales_clean.csv`) |
| :--- | :---: | :---: |
| **Total Rows** | 10,000 | 9,997 |
| **Math Inconsistencies** | 1,000+ rows | **0 rows (0%)** |
| **Invalid Enum/Date Strings** | Present (`UNKNOWN`/`ERROR`) | **Cleaned / Imputed** |
