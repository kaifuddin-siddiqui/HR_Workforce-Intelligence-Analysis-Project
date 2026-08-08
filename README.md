# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.


# 📊 End-to-End HR Workforce Intelligence & Attrition Analytics

<img width="1920" height="1007" alt="PBIDesktop_KBazToBwQv" src="https://github.com/user-attachments/assets/c3235f7a-f4aa-4949-89cf-02b09ebef7b5" />
<br>
<br>

***Caption: Live dynamic visual switching using Field Parameters in Power BI.***

---
## 🤖 The Dataset (AI Synthetic Data Generation)
To ensure data privacy and to practice working with complex, messy datasets, I used AI to generate a synthetic HR database. 

The raw data contained mismatches and unstandardized formats to real-world data challenges. The database consists of four interconnected tables:
*   **`employees`**: Contains personal details (ID, Name, Gender, Date of Birth, Hire Date).
*   **`department`**: Contains department details (Dept ID, Name, Location, Dept Head).
*   **`role`**: Contains job titles, role bands, and minimum/maximum salary brackets.
*   **`hr_metrics`**: Contains performance scores, attrition status, work-life balance ratings, and current salaries.

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
<br>
<br>
<table>
  <tr>
 <td><img width="375" height="297" alt="pgAdmin4_GOm1F6p2HM" src="https://github.com/user-attachments/assets/5f2dca90-784d-4444-b0e1-8fe04caeb9c6" /></td>
 <td><img width="438" height="337" alt="TI2tLMv5RD" src="https://github.com/user-attachments/assets/2bdc221d-fc17-4b33-991d-ffba850821c0" /></td>
 <td><img width="745" height="424" alt="pgAdmin4_ceFTo93fgp" src="https://github.com/user-attachments/assets/e83f22e7-6d1a-4c7b-adf2-b410ddc2c6f3" /></td>
  </tr>
</table>

 ---
 
3. **Data Cleaning & Engineering:** Refactored the database schema using `ALTER TABLE` to add features, backfilled records via `UPDATE` queries, and applied `EXTRACT`/`DATE_TRUNC` functions to derive time-based metrics like `Employee Age` and `Tenure` while enforcing. 
<br>
<img width="841" height="363" alt="pgAdmin4_XP7M6g3mSt" src="https://github.com/user-attachments/assets/f646522f-de6c-45cd-9d77-7477b6b1eb72" />
<br>

 ---
 
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
```

 ---
4. **CTE, Joins & Functions:** Calculated average performance, monthly overtime, and salary percentiles using `SQL Common Table Expressions (WITH clauses)`, `aggregations`, and `JOINs`.
<br>
<table>
  <tr>
 <td><img width="753" height="247" alt="RC9QaEAp0j" src="https://github.com/user-attachments/assets/5caf21a0-9a0e-4eea-a986-9914e58b984d" /></td>
 <td><img width="795" height="257" alt="kQeXXF4ODi" src="https://github.com/user-attachments/assets/38622992-afd1-459f-9c26-0b1cb3b039bc" /></td>
  </tr>
</table>
<br>
<table>
  <tr>
 <td><img width="699" height="255" alt="pgAdmin4_pW2SRipYIz" src="https://github.com/user-attachments/assets/cfdf1eae-a921-4d07-afb6-4d9429685ae0" /></td>
 <td><img width="733" height="365" alt="pgAdmin4_uhZh0zwC10" src="https://github.com/user-attachments/assets/14eee878-014b-48f4-b2be-38e104941c2e" /></td>
  </tr>
</table>
<br>
<br>

 ---
 
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
 ```

 ---
6. **Attrition Analysis Queries:** Aggregated resignation rates by age group, department, job role and salary bracket to uncover patterns before importing into BI tools.

<br>
<table>
  <tr>
 <td><img width="569" height="377" alt="pgAdmin4_RPlxCUbTaO" src="https://github.com/user-attachments/assets/034dc68d-223d-430b-a244-a4a9911d5015" /></td>
 <td><img width="761" height="345" alt="KK7mWSYktF" src="https://github.com/user-attachments/assets/37ce46c1-31db-4d37-b57d-8b1f9c174006" /></td>
 </tr>
</table>
<br>

 ```m
SQL Querys
--i)count of employees by age

select e.age,count(e.employee_id)as total_employees,
sum(h.attrition_check)as attrition_count, count(e.employee_id)-sum(attrition_check)
as total_working_employees,cast(sum(h.attrition_check)::numeric/count(e.employee_id)::numeric*100 as decimal(10,2))||'%'
as attrition_percentage from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by e.age;

--ii)count of employees by roles

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
 
* 🔗 **For full SQL query code & details:**
 <br>
 
  👉 **[Click here to view SQL Analysis README](<./SQL_HR_Workforce_Intelligence_Analysis_Files/README.md>)**
 <br>
   <br>

---

## 📊 Phase 2: Power BI Data Modeling & Reporting

### 1. Data Modeling (Star Schema)
* Structured the dataset using **Star Schema methodology** with a central Fact Table (`hr_metrics`) connected to Dimension Tables (`employees`, `department`, `role`, and `DimDate`).
<br>
<br>
<img width="960" height="469" alt="PBIDesktop_pTAaHGX4qH" src="https://github.com/user-attachments/assets/abd1f651-8a84-4fbe-b06f-5726aa1775f6" />
<br>

---
  
* Built a dedicated **Custom Date Table (`DimDate`)** using DAX to support advanced Time Intelligence calculations (YoY Growth, MTD, YTD).
<br>
<br>
<table>
  <tr>
 <td><img width="960" height="509" alt="PBIDesktop_Mf9ihhuYmA" src="https://github.com/user-attachments/assets/35cd456a-083b-4d79-9215-9f25d60f13b9" /></td>
 <td><img width="960" height="511" alt="SOqhAcjJhW" src="https://github.com/user-attachments/assets/30531736-7fb8-426c-9d1d-86912f732777" /></td>
 <td><img width="960" height="487" alt="pKZBQaGxDd1" src="https://github.com/user-attachments/assets/1360f9f1-afbe-441a-bdf2-56b4edd9d99f" /></td>
  </tr>
</table>

  ---
  
 ```m
M Code
= List.Dates(#date(1975,1,1),18110,#duration(1,0,0,0))
 ```

 ---
* **Inactive Relationship Management:** Managed complex date dimensions (e.g., *Hire Date* vs. *Termination Date*) using the **`USERELATIONSHIP`** DAX function without breaking model integrity.
  <br>
  <br>
  <img width="960" height="483" alt="zXCAqCdYBy" src="https://github.com/user-attachments/assets/2f359a9a-1b16-46f7-901c-34b8c3cbd1ff" />

 ---
 
### 2. Advanced DAX & Dynamic Features
* **Field Parameters:** Built dynamic metric slicers allowing end-users to seamlessly switch entire chart views between **Total Headcount**/**Total Employees**, **Attrition Count** and **Total Active Employees**.

 ---
<img width="960" height="292" alt="fluiUCoZ6G" src="https://github.com/user-attachments/assets/68efe989-a07b-425e-b6a8-e8ca07569c5c" />
<img width="703" height="205" alt="PBIDesktop_e6l0wLkULD" src="https://github.com/user-attachments/assets/ac99c71e-55cc-4387-ae3f-98bdd767cdef" />

 ---
* **Key DAX Measures Written:**
  * **Total Attrition:** `CALCULATE(COUNT('public hr_metrics'[attrition]),('public hr_metrics'[attrition]="yes"))`/`SUM('public hr_metrics'[attrition_check])`
  * **Attrition Rate %:** `Total_attrition_% = DIVIDE([Total_attrition],[Total_employees],0)`
 
  * **average over_time_ by parameter:** `VAR svalue = SELECTEDVALUE(total_measure[Parameter Order])
    VAR attrition = CALCULATE(AVERAGE('public hr_metrics'[overtime_hours_monthly]),'public hr_metrics'[attrition]="YES")
    VAR active = CALCULATE(AVERAGE('public hr_metrics'[overtime_hours_monthly]),'public hr_metrics'[attrition]="NO")
RETURN
SWITCH(svalue,0,CALCULATE(AVERAGE('public hr_metrics'[overtime_hours_monthly])),1,attrition,2,active)`

  * **Calculated Columns Measures:**
  * **Age_group:** `SWITCH(TRUE(),'public employees'[age]>=45,"45-50",'public employees'[age]>=36,"36-44",'public employees'[age]>=25,"25-35",'public employees'[age]>=18,"18-24")`
  * **salary_check:** `SWITCH(TRUE(),'public hr_metrics'[salary_annual_inr]>RELATED('public role'[base_max]),"High_Pay",
    'public hr_metrics'[salary_annual_inr]<=RELATED('public role'[base_max]),"In_Range",
    'public hr_metrics'[salary_annual_inr]<=RELATED('public role'[base_min]),"Under_Pay")`

   <br>
    <br>

* 🔗 **For full Power BI dashboard layout & DAX measures:**
   <br>
   <br>
    <br>
    
  👉 **[Click here to view Power BI README](<./POWER_BI_HR_Workforce_Intelligence_Analysis_Dashboard/README.md>)**
 <br>
   <br>
 
---
## Excel Power Pivot Report:

Created an Pivot report using Power Pivot to build data relationships.

<img width="747" height="199" alt="EXCEL_Egkro7NM18" src="https://github.com/user-attachments/assets/4573b765-4048-476c-a827-5e4538c042de" />
<img width="751" height="288" alt="mJKVDRE4U8" src="https://github.com/user-attachments/assets/0bccccf4-5ae8-4926-a6ce-300ebc24697f" />

Simplifies complex data into clear report for quick and  decision-making.

---
## 💡 Business Impact & Benefits
1. Instantly identify departments, roles, or age groups with the highest turnover rates.
2. Analyze the correlation between performance metrics, training hours, and employee retention.
3. Improves Retention: By identifying the root causes of attrition (e.g., low salary, poor work-life balance), HR can take proactive steps to retain top talent.
4. Make proactive, data-driven decisions to improve workforce planning and optimize the business structure.

---
## 📁 Repository Structure
```text
├── HR_Workforce-Intelligence-Analysis-Project/
│  
├── POWER_BI_HR_Workforce_Intelligence_Analysis_Dashboard/
│ 
│   ├──HR_Workforce Intelligence Analysis.pbix
│    └──README.md
│ 
├── SQL_HR_Workforce_Intelligence_Analysis_Files/
│ 
│   ├── HR_Workforce_Intelligence_Analysis.sql
│   └──HR_metrics.csv
│   └──README.md
│   └──department.csv
│   └──employees.csv
│   └──role.csv
├──README.md

```

---

## 🚀 How to Run / Reproduce This Project
1. **Database Setup:** Run the `HR_Workforce_Intelligence_Analysis.sql` scripts of the`SQL_HR_Workforce_Intelligence_Analysis_Files` folder to create tables and generate analytical views.
2. **Open Power BI File:** Open `POWER_BI_HR_Workforce_Intelligence_Analysis_Dashboard` in Power BI Desktop.
3. **Interact:** Use the slicers on the sidebar and Field Parameter controls to explore metrics & vishuals dynamically.
