# ☕ Cafe Sales Data Cleaning & Reconstruction (MySQL)

## 📌 Business Overview
Proyek ini bertujuan untuk melakukan **End-to-End Data Cleaning** pada dataset transaksi kafe (`dirty_cafe_sales.csv`) sebanyak ~10.000 baris. Dataset awal memiliki kendala kualitas data seperti string error (`'UNKNOWN'`, `'ERROR'`), missing values, serta inkonsistensi matematika pada kolom harga dan kuantitas.

## 🎯 Key Objectives
1. **Schema Standardization**: Menata skema tabel MySQL menggunakan tipe data `ENUM` dan `DATE`.
2. **Mathematical Reconstruction**: Memperbaiki nilai transaksi yang hilang menggunakan pendekatan aljabar ($Total = Quantity \times Price$) dan logika katalog harga.
3. **Audit & Validation**: Memastikan 0% error matematika dan integritas data 100% konsisten sebelum siap dipakai untuk analisis/dashboard.

## 🛠️ Tools & Technologies
- **Database**: MySQL Server
- **Data Export**: Python (`pandas`, `mysql-connector`) / MySQL CLI
- **Version Control**: Git & GitHub

## 🧹 Cleaning Workflow Highlights
- **ENUM & Categorical Handling**: Mengubah teks invalid menjadi `NULL` murni tanpa merusak constraint skema.
- **Deductive Price Mapping**:
  - `Cookie` = $1.00 | `Coffee` = $2.00 | `Tea` = $1.50
  - `Cake` / `Juice` = $3.00 | `Smoothie` / `Sandwich` = $4.00 | `Salad` = $5.00
- **Math Auto-Correction**:
  $$\text{price\_per\_unit} = \frac{\text{total\_spent}}{\text{quantity}}$$

## 📊 Summary Comparison
| Metric | Raw Dataset (`dirty_cafe_sales.csv`) | Clean Dataset (`cafe_sales_clean.csv`) |
| :--- | :---: | :---: |
| **Total Rows** | 10,000 | 9,997 |
| **Math Inconsistencies** | 1,000+ rows | **0 rows (0%)** |
| **Invalid Enum/Date Strings** | Present (`UNKNOWN`/`ERROR`) | **Cleaned / Imputed** |
