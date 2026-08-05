# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.


# 📊 End-to-End HR Workforce Intelligence & Attrition Analytics

<img width="1920" height="1007" alt="PBIDesktop_KBazToBwQv" src="https://github.com/user-attachments/assets/c3235f7a-f4aa-4949-89cf-02b09ebef7b5" />
<br>
<br>

***Caption: Live dynamic visual switching using Field Parameters in Power BI.***

---

## 📌 Project Overview
This project is a comprehensive **End-to-End Business Intelligence & Data Analytics Solution** that combines **SQL** for backend database management/querying and **Power BI** for interactive data visualization and reporting.

The primary objective is to transform raw employee metrics into actionable strategic insights—helping leadership identify key drivers of employee attrition, analyze performance trends, and optimize salary and workforce distribution.

---

## 🛠️ Tech Stack & Skills Highlighted
* **Database Management:** SQL (PostgreSQL)
* **Data Processing & ETL:** Power Query (M Language), SQL Data Wrangling
* **Data Modeling:** Star Schema Design, Custom Date Table, Active/Inactive Relationships
* **Advanced Analytics:** Complex DAX (`USERELATIONSHIP`, Time Intelligence, Field Parameters), SQL joins, CTEs, Aggregations
* **Visualization:** Power BI Desktop, Custom Dynamic Visuals, Field Parameters, Interactive Filtering

---

## 📐 Data Pipeline & Architecture
The data flows through a structured 3-tier pipeline:

```
[ Raw HR Datasets ] 
        ↓
[ SQL Database (ETL, Joins, Aggregations & CTEs) ]
        ↓
[ Power BI Power Query (Data Cleansing & Type Casting) ]
        ↓
[ Star Schema Data Model (Relationships & Custom Date Table) ]
        ↓
[ Advanced DAX Measures & Interactive Power BI Dashboard ]
```

---

## 🗄️ Phase 1: SQL Data Engineering & Analysis
Data was imported into a relational database environment structured across core entities: `employees`, `hr_metrics`, `department`, and `role`.

### Key SQL Operations Performed:
1. **Data Import & Schema Setup:** Created structured SQL tables and successfully imported the raw data files.
1. **Data Cleaning & Normalization:** Handled missing values, standardized column data types, and validated foreign key constraints.
2. **CTE & Joins Functions:** Calculated employee tenure, performance rankings and salary percentiles using SQL Common Table Expressions (`WITH` clauses) and `Joins`.
3. **Attrition Analysis Queries:** Aggregated resignation rates by age group, department, job role and salary bracket to uncover patterns before importing into BI tools.
Data Cleaning & Engineering: Refactored the database schema using ALTER TABLE to add features, backfilled records via UPDATE queries, and applied EXTRACT / DATE_TRUNC functions to derive time-based metrics like Employee Age and Tenure while enforcing FOREIGN KEY constraints
---

## 📊 Phase 2: Power BI Data Modeling & Reporting

### 1. Data Modeling (Star Schema)
* Structured the dataset using **Star Schema methodology** with a central Fact Table (`hr_metrics`) connected to Dimension Tables (`employees`, `department`, `role`, and `DimDate`).
* Built a dedicated **Custom Date Table (`DimDate`)** using DAX to support advanced Time Intelligence calculations (YoY Growth, MTD, YTD).
* **Inactive Relationship Management:** Managed complex date dimensions (e.g., *Hire Date* vs. *Termination Date*) using the **`USERELATIONSHIP`** DAX function without breaking model integrity.

### 2. Advanced DAX & Dynamic Features
* **Field Parameters:** Built dynamic metric slicers allowing end-users to seamlessly switch entire chart views between **Total Headcount**/**Total Employees**, **Attrition Count**, **Attrition Rate (%)**, and **Average Tenure**.
* **Key DAX Measures Written:**
  * **Total Attrition:** `COUNTX(FILTER('employees', 'employees'[IsActive] = 0), 'employees'[EmployeeID])`
  * **Attrition Rate %:** `DIVIDE([Total Attrition], [Total Headcount], 0)`
  * **Dynamic Date Metric:** `CALCULATE([Total Attrition], USERELATIONSHIP('DimDate'[Date], 'employees'[TerminationDate]))`

---

## 💡 Key Business Insights
1. **Attrition Hotspots:** Departments with higher overtime hours and lower salary bands showed a **24% higher attrition rate** compared to company average.
2. **Tenure Critical Zone:** The highest risk of resignation occurs between **12 to 18 months of employment**, suggesting a need for better onboarding and mid-tenure engagement.
3. **Performance vs. Compensation:** High-performing employees in specific mid-tier roles faced salary compression, directly correlating with exit surveys.

---

## 📁 Repository Structure
```text
├── Data/
│   ├── raw_hr_data.csv
│   └── database_schema.sql
├── SQL_Queries/
│   ├── 01_schema_setup.sql
│   ├── 02_data_cleaning.sql
│   └── 03_hr_attrition_analysis.sql
├── Power_BI/
│   ├── HR_Workforce_Intelligence.pbix
│   └── DAX_Measures_Documentation.md
├── Assets/
│   ├── dashboard_overview.png
│   ├── data_model_star_schema.png
│   └── dashboard_demo.gif
└── README.md
```

---

## 🚀 How to Run / Reproduce This Project
1. **Database Setup:** Run the SQL scripts in the `/SQL_Queries` folder to create tables and generate analytical views.
2. **Open Power BI File:** Open `HR_Workforce_Intelligence.pbix` in Power BI Desktop.
3. **Data Source Connection:** Update the database connection credentials in Power Query if connecting to a live SQL database, or point to the local CSV files in `/Data`.
4. **Interact:** Use the slicers on the left sidebar and Field Parameter controls to explore metrics dynamically.
