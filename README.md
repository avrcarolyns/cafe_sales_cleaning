## 📌 Project Description
This repository demonstrates an end-to-end relational database cleaning workflow in **MySQL** applied to a café transactional dataset (`dirty_cafe_sales.csv`). The project addresses real-world data quality anomalies and transforms raw, inconsistent logs into a clean, analytical production table (`cafe_sales_clean`).

### Key Highlights & Technical Accomplishments:
- **Schema & ENUM Integrity**: Standardized invalid string entries (`'UNKNOWN'`, `'ERROR'`) across categorical (`ENUM`) and `DATE` columns, handling them natively as `NULL` without violating schema constraints.
- **Algebraic & Deductive Reconstruction**: Restored missing numerical values (`quantity`, `price_per_unit`, `total_spent`) using mathematical logic ($Total = Quantity \times Price$) and strict menu catalog price mappings ($1.00 - $5.00).
- **Domain-Specific Imputation**: Resolved multi-column missingness by inferring item categories and unit prices through price-matrix constraints and business rules.
- **Audit & Quality Assurance**: Executed automated SQL verification scripts to validate 0% mathematical discrepancies, non-negative bounds, and date range validity across all 10,000 rows.
