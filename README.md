# ☕ Cafe Sales Analytics: End-to-End Data Pipeline & Executive Dashboard

![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-Analytics-blue?style=for-the-badge)

An end-to-end data analytics project transforming **10,000 raw, corrupted cafe transaction records** into a clean, audited dataset and an interactive **Power BI Executive Dashboard**. The project combines SQL data cleaning, Python Monte Carlo sensitivity testing, and advanced DAX modeling.

---

## 📌 Executive Summary & Key Results

- **Gross Revenue Preserved:** **$89,155.50** across **9,997 validated transactions** (restored 100% financial accuracy).
- **Data Quality:** Reduced 10,000 messy raw rows down to 9,997 cleaned records (dropped only 3 unrecoverable null rows).
- **Basket Metrics:** Average Order Value (**AOV**) of **$8.92** with an average basket size of **3.02 items**.
- **Trend Integrity:** Python Monte Carlo simulation confirmed that date imputation introduces a maximum shift of **±2.1%** in MoM trends, maintaining 100% trajectory stability.

---

## 🛠️ Project Architecture & Workflow

Raw CSV (10,000 rows) `->` SQL Data Cleaning & Imputation (Fix prices, calculate totals, handle missing dates) `->`
Python Sensitivity Analysis (Monte Carlo testing on date imputation bias) `->` Power BI Data Model & DAX (Star schema, dynamic measures, slicers) `->` Executive BI Dashboard (Product mix, sales channels, payment analysis)
---

## 📊 Key Business Insights

1. **Product Revenue Mix:** High-priced food items (**Salad at $5.00** and **Smoothie at $4.00**) drive overall revenue despite lower transaction frequency compared to entry-level beverages (**Coffee at $2.00**).
2. **Predictable Demand:** Monthly revenue maintained a tight, stable range between **$7,000 and $7,600** throughout FY 2023, indicating low seasonal volatility and stable inventory requirements.
3. **Fulfillment Preference:** **In-store dining** heavily outperforms Takeaway orders across all menu categories, emphasizing physical capacity management.
4. **Payment Dynamics:** **Credit Card** is the leading payment channel (**31.22% / $27.84K**), followed evenly by Digital Wallet, Cash, and Unknown channels (~23% each).

---

## 📐 DAX Metrics Documentation

| Measure Name | DAX Formula | Description |
| :--- | :--- | :--- |
| **Total Revenue** | `Total Revenue = SUM('Cafe Sales'[Total Spent])` | Calculates cumulative gross revenue ($89,155.50). |
| **Total Items Sold** | `Total Items Sold = SUM('Cafe Sales'[Quantity])` | Calculates total quantity of menu items sold (30,203). |
| **Total Transactions** | `Total Transactions = COUNTROWS('Cafe Sales')` | Counts total validated transaction rows (9,997). |
| **Average Order Value** | `Average Order Value = DIVIDE([Total Revenue], [Total Transactions], 0)` | Computes average spent per transaction ($8.92). |
| **Avg Items per Txn** | `Avg Items per Txn = DIVIDE([Total Items Sold], [Total Transactions], 0)` | Computes average units purchased per order (3.02). |
---

## 👤 Author & Contact
Avrillia Carolyn Sidabutar
avrcarolyn04@gmail.com
www.linkedin.com/in/avrcarolyns
