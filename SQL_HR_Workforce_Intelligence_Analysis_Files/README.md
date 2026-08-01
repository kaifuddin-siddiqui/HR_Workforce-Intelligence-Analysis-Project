# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.

# HR Analytics & Data Processing Pipeline (SQL)

![Project Banner/Main Screenshot](replace_this_with_your_image_link_here.png)
*Provide a brief caption for your screenshot here, e.g., "SQL Query Execution showing Attrition Analysis"*

## 📌 Project Overview
This project showcases an end-to-end data processing and analytics pipeline using **SQL (PostgreSQL)**. The goal of this project was to take raw, unorganized HR data, clean it, structure it, and extract meaningful business insights regarding employee retention, salary distribution, and workforce demographics. 

This project demonstrates strong problem-solving skills, data engineering capabilities, and business intelligence reporting logic.

## 🤖 1. The Dataset (AI Synthetic Data Generation)
To ensure data privacy and to practice working with complex, messy datasets, I used AI to generate a synthetic HR database. 

The raw data intentionally contained mismatches, missing values, and unstandardized formats to simulate real-world data challenges. The database consists of four interconnected tables:
*   **`employees`**: Contains personal details (ID, Name, Gender, Date of Birth, Hire Date).
*   **`department`**: Contains department details (Dept ID, Name, Location, Dept Head).
*   **`role`**: Contains job titles, role bands, and minimum/maximum salary brackets.
*   **`hr_metrics`**: Contains performance scores, attrition status, work-life balance ratings, and current salaries.

## 🧹 2. Data Cleaning & Transformation (SQL)
The initial AI-generated data was mismatched and unorganized. I used advanced SQL queries to clean, validate, and standardize the data. 

**Key Cleaning Steps Performed:**
*   **Data Type Standardization:** Corrected formatting for dates and numeric values.
*   **Calculated Columns:** Extracted and calculated exact employee `age` and `working_years` (tenure) dynamically using dates.
*   **Handling NULLs & Missing Data:** Identified and handled missing values in critical columns.
*   **Data Integrity Checks:** Used SQL `JOIN`s to verify that employee IDs matched across all four tables and fixed structural mismatches.
*   **Categorization:** Created new conditional columns (e.g., converting text-based attrition to binary checks for easier calculation).

![Data Cleaning Screenshot](replace_this_with_your_cleaning_screenshot_link.png)
*Caption: SQL queries used to calculate age and clean the dataset.*

## 📊 3. Data Analysis & Key Questions Solved
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

## 💡 4. Business Value & Project Benefits
Why is this project useful for a business?
1.  **Improves Retention:** By identifying the root causes of attrition (e.g., low salary, poor work-life balance), HR can take proactive steps to retain top talent.
2.  **Optimizes Budget:** The "Salary Check" query helps management ensure fair compensation, identifying discrepancies where people are paid outside their designated role bands.
3.  **Automates Reporting:** The SQL views and structured queries created in this project can be directly connected to visualization tools (like Power BI or Tableau) to create automated daily HR dashboards.

## 🛠️ Tech Stack Used
*   **Database:** PostgreSQL (SQL)
*   **Techniques:** CTEs (Common Table Expressions), Aggregate Functions, Window Functions, Complex Joins, Date/Time Functions, CASE Statements.
*   **Tools:** AI (Data Generation), pgAdmin / SQL Server Management Studio.

---
*Feel free to explore the SQL scripts in this repository to see the step-by-step logic used for cleaning and analysis.*
