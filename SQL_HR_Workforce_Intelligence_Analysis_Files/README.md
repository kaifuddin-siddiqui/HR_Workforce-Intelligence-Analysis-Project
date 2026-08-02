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
<br>
<br>
<img width="871" height="427" alt="pgAdmin4_KotW3Arlen" src="https://github.com/user-attachments/assets/ee0ccfd4-c5d1-4a15-8efa-6ed0a088bb5b" />
<br>
<br>

**SQL Query**
 ```m
SQL Query
---fill data into column attrition_check

update hr_metrics
set attrition_check=case
when Lower(attrition) 
='no'then 0 else 1 end ;
 ```
<br>

* **Schema Optimization**: Dropped unnecessary columns to reduce noise and renamed existing columns for better clarity and standardization.
<br>
SQL Querys

 ```m
SQL Querys
--drop column performance_2023
alter table hr_metrics
drop column performance_2023;

--rename column performance_2024 to performance
alter table hr_metrics
rename column performance_2024 to performance;

--rename column training_count_2024 to training_count
alter table hr_metrics
rename column training_count_2024 to training_count;

--rename column promotion_last_2yrs to promotion
alter table hr_metrics
rename column promotion_last_2yrs to promotion;

--rename column training_hours_2024 to training_hours
alter table hr_metrics
rename column training_hours_2024 to training_hours;
 ```
<br>
<br>

## 📊 2. Data Analysis & Key Questions Solved
Once the data was clean, I performed exploratory data analysis (EDA) to answer critical HR business questions. 

**Key Queries Written & Insights Generated:**

*   **Total Workforce Count:** Calculated the exact number of active vs. past employees.
<br>
<br>
*   <img width="442" height="100" alt="pgAdmin4_i6tv4K4jda" src="https://github.com/user-attachments/assets/3e2ca8dd-b14f-43b5-a26a-6428aa2cbc1b" />
<br>
<br>
SQL Query

 ```m
SQL Query
--total_emp,attrition,total_working_emp,attrition percentage

select count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(h.attrition_check)::numeric/count(e.employee_id)::numeric*100)::decimal(10,2) ||'%'as attrition_percentage
from employees e left join
hr_metrics h on e.employee_id=h.employee_id;
 ```

*   **Overall Attrition Rate:** Determined the percentage of employees leaving the company.
<br>
<br>
  <img width="570" height="167" alt="pgAdmin4_2xv62uYlMO" src="https://github.com/user-attachments/assets/1fde3ad3-94ce-4ee4-a57e-79dba3d0be66" />
  <br>
<br>

 ```m
SQL Query
--total_employees by education analysis

select e.education,count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(attrition_check)::numeric/count(e.employee_id)::numeric * 100)::decimal(10,2)||'%'
as attrition_percentage
from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by e.education;
 ```

*   **Gender-wise Analysis:** Analyzed employee distribution and attrition trends based on gender.
<br>
<br>
<img width="578" height="150" alt="pgAdmin4_MXtXILRt02" src="https://github.com/user-attachments/assets/a06cf570-be6b-4547-8b30-0858f2a0fc85" />
<br>
<br>

 ```m
---ii)total_employees by gender analysis

select e.gender,count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(attrition_check)::numeric/count(e.employee_id)::numeric * 100)::decimal(10,2)||'%'
as attrition_percentage
from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by gender;
 ```
<br>
<br>

*   **Department & Role Breakdown:** Grouped employees to see which departments have the highest turnover.
<br>
<br>

  *   **Performance & Work-Life Balance:** Analyzed average training hours, job satisfaction, and overtime to see how they correlate with employee attrition.
<br>
<br><table>
  <tr>
 <td><img width="753" height="247" alt="RC9QaEAp0j" src="https://github.com/user-attachments/assets/5caf21a0-9a0e-4eea-a986-9914e58b984d" /></td>
 <td><img width="795" height="257" alt="kQeXXF4ODi" src="https://github.com/user-attachments/assets/38622992-afd1-459f-9c26-0b1cb3b039bc" /></td>
  </tr>
</table>
<br>
<br>

 ```m
SQL Querys
---i)total_data_by department

with
employee_count  as
(select dept_id, count(employee_id)as employees from employees 
group by dept_id )
select d.dept_id,d.dept_name,d.dept_head,e.employees,sum(attrition_check)as attrition,
(e.employees-sum(attrition_check)) as working_employees,
((sum(attrition_check)::numeric/e.employees::numeric)*100)::int::text||'%' as attrition_percentage,
avg(h.performance)::decimal(10,2)as avg_performance,avg(h.training_count)::decimal(10,2)as avg_total_training_attends,
avg(h.training_hours)::decimal(10,2)as avg_total_training_hours,avg(h.job_satisfaction)::decimal(10,2)
as avg_job_satisfaction_ratings,avg(h.work_life_balance)::decimal(10,2)as avg_work_life_balance_ratings,
avg(h.overtime_hours_monthly)::decimal(10,2)as avg_overtimes_hours_monthly
from department d left join
hr_metrics h on d.dept_id = h.dept_id
left join employee_count e on d.dept_id = e.dept_id
group by d.dept_id,d.dept_name,d.dept_head,e.employees
order by d.dept_id;

--count of employees by roles

with 
employees as
(select r.role_id,r.role_name,r.band,count(e.employee_id)as employees from role r left join
employees e on r.role_id=e.role_id group by r.role_id),
attrition as
(select r.role_id,sum(h.attrition_check)as attrition from role r
left join hr_metrics h on r.role_id=h.role_id group by r.role_id)
select e.role_id,e.role_name,e.band,e.employees,a.attrition,
e.employees-a.attrition as total_working_employees,(a.attrition::numeric/e.employees::numeric
*100)::decimal(10,2)||'%'as attrition_percentage from employees e
left join attrition a on e.role_id=a.role_id order by e.role_id;
 ```
<br>
<br>

*   **Salary Compression & Check:** Wrote complex `CASE` statements and `JOIN`s to compare actual salaries against role bands, identifying employees who are **'Underpaid'** or **'Overpaid'**.
   <br>
<br><table>
  <tr>
 <td><img width="699" height="255" alt="pgAdmin4_pW2SRipYIz" src="https://github.com/user-attachments/assets/cfdf1eae-a921-4d07-afb6-4d9429685ae0" /></td>
 <td><img width="733" height="394" alt="pgAdmin4_uhZh0zwC10" src="https://github.com/user-attachments/assets/ebe503e4-b089-4ffc-ac8f-cf31594a9aec" /></td>
  </tr>
</table>
<br>
<br>

 ```m
SQL Querys
---department wise salery check 
with
dep as
(select d.dept_id,d.dept_name,d.dept_head,sum(h.salary_annual_inr)as actual_salary
from department d left join hr_metrics h on d.dept_id=h.dept_id
where h.attrition_check='1' group by d.dept_id),
ran as
(select h.dept_id,r.role_id,r.role_name,r.band,sum(r.base_min)as min_salary,
sum(base_max)as max_salary,h.attrition_check as attrition from hr_metrics h
left join role r on h.role_id=r.role_id where h.attrition_check='1'
group by h.dept_id,r.role_id,h.attrition_check)

---role wise salery check 
select r.role_id,r.role_name,r.band,r.base_min,r.base_max,sum(h.salary_annual_inr) as actual_salary,
case when sum(h.salary_annual_inr) between r.base_max and r.base_min then 'in range'
when sum(h.salary_annual_inr)<r.base_min then 'under paid' else 'over paid' end as checking
 from role r left join hr_metrics h on trim(r.role_id)=trim(h.role_id)
group by r.role_id,r.role_name,r.band order by r.role_id;
 ```
<br>
<br>

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
