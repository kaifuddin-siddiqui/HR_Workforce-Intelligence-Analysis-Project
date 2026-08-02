# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.

# HR Analytics & Data Processing Pipeline (SQL)

## 📌 Project Overview
This project showcases an end-to-end data processing and analytics pipeline using **SQL (PostgreSQL)**. The goal of this project was to take raw, unorganized HR data, clean it, structure it, and extract meaningful business insights regarding employee retention, salary distribution, and workforce demographics. 

This project demonstrates strong problem-solving skills, data engineering capabilities, and business intelligence reporting logic.

---
## 🛠️ Tech Stack Used
*   **Database:** PostgreSQL (SQL)
*   **Techniques:** CTEs (Common Table Expressions), DDL, DML, Aggregate Functions, Complex Joins, Date/Time Functions, CASE Statements.
*   **Tools:**  Synthetic Data/AI (Data Generation), pgAdmin / SQL Server Management Studio.

---

## 🧹 1. Data Cleaning & Transformation (SQL)
The raw dataset was imported by creating tables in SQL. The initial  AI-generated data contained structural inconsistencies, mismatches, and unclean records. I performed comprehensive data cleaning and transformation to make the dataset analysis-ready.

**Key Cleaning Steps Performed:**

*   **Data Import & Schema Setup**: Created structured SQL tables and successfully imported the raw data files.
<br>
<br>
<br>
<table>
  <tr>
 <td><img width="375" height="297" alt="pgAdmin4_GOm1F6p2HM" src="https://github.com/user-attachments/assets/5f2dca90-784d-4444-b0e1-8fe04caeb9c6" /></td>
 <td><img width="438" height="337" alt="TI2tLMv5RD" src="https://github.com/user-attachments/assets/2bdc221d-fc17-4b33-991d-ffba850821c0" /></td>
 <td><img width="745" height="424" alt="pgAdmin4_ceFTo93fgp" src="https://github.com/user-attachments/assets/e83f22e7-6d1a-4c7b-adf2-b410ddc2c6f3" /></td>
  </tr>
</table>
<br>

---
* ### **Data Cleaning & Validation**:
### **Identified and fixed data mismatches, typos, and incorrect entries across records.**
---

*   **Calculated Columns:** Extracted and calculated exact employee `age` and `working_years` (tenure) dynamically using dates.

<br>
<br>
<img width="841" height="363" alt="pgAdmin4_XP7M6g3mSt" src="https://github.com/user-attachments/assets/f646522f-de6c-45cd-9d77-7477b6b1eb72" />
<br>
<br>

**SQL Querys**

 ```m

SQL Querys

--Cleaning_&_alter_data_steps
---add column age

 alter table employees
 add column age smallint;

--fill the column age
---1)using extract only years

UPDATE employees 
set  age = extract(year from age((select				
max(attrition_date) from hr_metrics),date_of_birth));

---2)using CTEs with date_trunc for y-m-d
with
max_date as (select max(attrition_date)as max_dates from hr_metrics)
update employees e
set age = DATE_TRUNC('day',age(m.max_dates,date_of_birth))from max_date m;

---add column working_years of employees

ALTER TABLE employees
add column working_years varchar(30);

---1)using CTEs & extract only years
with
max_date as
(select max(attrition_date) as max_dates from hr_metrics)
UPDATE employees e
set working_years = extract(year from age(m.max_dates,hire_date))
from max_date m;

 ---2)using date_trunc for y-m-d
UPDATE employees
set working_years = date_trunc('day',age((select max(attrition_date)
from hr_metrics),hire_date));
 ```
 *   **Categorization:** Created new conditional columns (e.g., converting text-based attrition to binary checks for easier calculation).

<img width="871" height="427" alt="pgAdmin4_KotW3Arlen" src="https://github.com/user-attachments/assets/ee0ccfd4-c5d1-4a15-8efa-6ed0a088bb5b" />

---fill data into column attrition_check

update hr_metrics
set attrition_check=case
when Lower(attrition) 
='no'then 0 else 1 end ;
  
* **Schema Optimization**: Dropped unnecessary columns to reduce noise and renamed existing columns for better clarity and standardization.
![Data Cleaning Screenshot](replace_this_with_your_cleaning_screenshot_link.png)
*Caption: SQL queries used to calculate age and clean the dataset.*

## 📊 2. Data Analysis & Key Questions Solved
Once the data was clean, I performed exploratory data analysis (EDA) to answer critical HR business questions. 

**Key Queries Written & Insights Generated:**
*   **Total Workforce Count:** Calculated the exact number of active vs. past employees.
*   **Overall Attrition Rate:** Determined the percentage of employees leaving the company.
*   **Gender-wise Analysis:** Analyzed employee distribution and attrition trends based on gender.
*   **Department & Role Breakdown:** Grouped employees to see which departments have the highest turnover.
*   **Salary Compression & Check:** Wrote complex `CASE` statements and `JOIN`s to compare actual salaries against role bands, identifying employees who are **'Underpaid'** or **'Overpaid'**.
*   **Performance & Work-Life Balance:** Analyzed average training hours, job satisfaction, and overtime to see how they correlate with employee attrition.

![Data Analysis Screenshot](replace_this_with_your_analysis_screenshot_link.png)
*Caption: Output showing the Salary Check and Attrition Breakdown.*

## 💡 3. Business Value & Project Benefits
Why is this project useful for a business?
1.  **Improves Retention:** By identifying the root causes of attrition (e.g., low salary, poor work-life balance), HR can take proactive steps to retain top talent.
2.  **Optimizes Budget:** The "Salary Check" query helps management ensure fair compensation, identifying discrepancies where people are paid outside their designated role bands.
3.  **Automates Reporting:** The SQL views and structured queries created in this project can be directly connected to visualization tools (like Power BI or Tableau) to create automated daily HR dashboards.

## 🤖 The Dataset (AI Synthetic Data Generation)
To ensure data privacy and to practice working with complex, messy datasets, I used AI to generate a synthetic HR database. 

The raw data intentionally contained mismatches, missing values, and unstandardized formats to simulate real-world data challenges. The database consists of four interconnected tables:
*   **`employees`**: Contains personal details (ID, Name, Gender, Date of Birth, Hire Date).
*   **`department`**: Contains department details (Dept ID, Name, Location, Dept Head).
*   **`role`**: Contains job titles, role bands, and minimum/maximum salary brackets.
*   **`hr_metrics`**: Contains performance scores, attrition status, work-life balance ratings, and current salaries.
*Feel free to explore the SQL scripts in this repository to see the step-by-step logic used for cleaning and analysis.*
