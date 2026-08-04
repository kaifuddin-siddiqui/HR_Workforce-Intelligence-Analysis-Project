# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.


# 📊 HR Workforce Intelligence Dashboards (Power BI)
<br>
<br>
<table>
  <tr>
 <td><img width="629" height="364" alt="TjR5gAzUnJ" src="https://github.com/user-attachments/assets/88637ea0-966f-4b20-a614-57136228e43e" /></td>
<td><img width="464" height="382" alt="PBIDesktop_OHCWQreN6u" src="https://github.com/user-attachments/assets/8c2f06f5-5515-41ce-aa9a-3b8c774918c9" /></td>
<td><img width="433" height="362" alt="PBIDesktop_YNCCFaw8Mo" src="https://github.com/user-attachments/assets/2585bda1-af52-4b34-83b0-dd6a5c82179f" /></td>
<td><img width="596" height="370" alt="PBIDesktop_dJ8n0RRwGj" src="https://github.com/user-attachments/assets/eb0d71c1-98d1-4319-840f-1b728da45322" /></td>
  </tr>
</table>

*Caption: HR Workforce Intelligence Dashboards.*
---

## 📌 Project Overview
This project is an advanced, interactive Power BI dashboard designed to analyze HR metrics, track workforce demographics, and uncover the root causes of employee attrition. Building upon a structured SQL database, this dashboard transforms raw HR data into actionable business intelligence.

The primary objective of this project is to showcase advanced Power BI capabilities, including complex data modeling, dynamic DAX calculations, and interactive reporting tailored for executive decision-making.


## ⚙️ 1. Data Extraction & Power Query (ETL)
Data was initially stored in a database environment. I established a connection to import/load the core tables: `hr_metrics`, `employees`, `department`, and `role`. 
Using **Power Query**, I performed data shaping, applied necessary transformations, and ensured data types were fully optimized for the semantic model.

<br>
<table>
  <tr>
 <td><img width="960" height="509" alt="vWX3cY02UW" src="https://github.com/user-attachments/assets/d60de900-bb97-43a5-96c8-73c9b4817ab7" /></td>
 <td><img width="960" height="484" alt="vQsLTAHpPZ" src="https://github.com/user-attachments/assets/f70d8cab-4e3b-4b59-a3d5-f1d046e765ac" /></td></tr>
</table>
<table>
  <tr>
 <td><img width="960" height="509" alt="PBIDesktop_Mf9ihhuYmA" src="https://github.com/user-attachments/assets/35cd456a-083b-4d79-9215-9f25d60f13b9" /></td>
 <td><img width="960" height="511" alt="SOqhAcjJhW" src="https://github.com/user-attachments/assets/30531736-7fb8-426c-9d1d-86912f732777" /></td>
  </tr>
</table>

---
<br>

## 🗂️ 2. Data Modeling & Star Schema
A highly optimized data model is the backbone of this dashboard. 
* **Star Schema:** I structured the data using a Star Schema methodology to ensure fast query performance and intuitive relationship management.
<br>
<img width="960" height="469" alt="PBIDesktop_pTAaHGX4qH" src="https://github.com/user-attachments/assets/bd76182b-e443-403c-9bb3-e6e60cfb7011" />

---
<br>

* **Date Table:** I generated a comprehensive, custom Date Table to unlock powerful Time Intelligence capabilities across the dataset.
<br>
<br>
<table>
  <tr>
 <td><img width="960" height="509" alt="PBIDesktop_Mf9ihhuYmA" src="https://github.com/user-attachments/assets/35cd456a-083b-4d79-9215-9f25d60f13b9" /></td>
 <td><img width="960" height="511" alt="SOqhAcjJhW" src="https://github.com/user-attachments/assets/30531736-7fb8-426c-9d1d-86912f732777" /></td>
  </tr>
</table>

---
<br>
<img width="960" height="487" alt="pKZBQaGxDd1" src="https://github.com/user-attachments/assets/1360f9f1-afbe-441a-bdf2-56b4edd9d99f" />

---
<br>
<br>

* **Advanced Relationships (`USERELATIONSHIP`):** The model required complex relationship structures. To handle multiple date filters and dimensions, I managed inactive relationships effectively using the `USERELATIONSHIP` DAX function, ensuring accurate calculations without compromising model integrity.
<br>
<img width="960" height="509" alt="xm1bdMKuqj" src="https://github.com/user-attachments/assets/1bbe531b-f37a-43de-bf7a-979d27fd3b20" />

---
<img width="960" height="483" alt="zXCAqCdYBy" src="https://github.com/user-attachments/assets/ba71c39f-fba6-4f5c-8686-2e5ef07cba3f" />
<br>

---
<br>

## 🧮 3. Advanced DAX & Dynamic Visuals
To make the dashboard highly interactive and insightful, I utilized several advanced Power BI features with the help of AI for optimization:
<br>
<br>
<br>
<img width="1920" height="1007" alt="PBIDesktop_XxQOXX8Tt9" src="https://github.com/user-attachments/assets/222e978a-187e-49b8-b757-a424d3148ed9" />
<br>

---
* **Field Parameters for Dynamic Reporting:** I implemented Field Parameters to give the end-user ultimate control. Through a single slicer, users can dynamically switch the metrics displayed across the dashboard's visuals (e.g., instantly toggling the charts to analyze 'Total Employees' vs. 'Attrition Employees').
<br>
<img width="960" height="137" alt="PBIDesktop_Q1XNmT5t6l5 png5" src="https://github.com/user-attachments/assets/9f4ddb63-df06-44cf-85e3-abc4c2ba7dac" />

---

<img width="960" height="292" alt="fluiUCoZ6G" src="https://github.com/user-attachments/assets/6a226b95-6461-4e15-aef9-e77e892ed5e6" />

---
<img width="882" height="135" alt="7v7kzI51wG" src="https://github.com/user-attachments/assets/44910020-49ef-475e-9a0f-e986d4a33fe7" />

---
<img width="703" height="205" alt="PBIDesktop_e6l0wLkULD" src="https://github.com/user-attachments/assets/db93928c-54a5-4695-89e6-ff582c6dc8c7" />

---
<br>
<br>

* **Calculated Columns:** Created strategic calculated columns to categorize and segment data effectively (e.g., creating custom Age Groups and Work Experience bands).
<table>
  <tr>
 <td><img width="960" height="492" alt="PBIDesktop_PMpoNeoRUl" src="https://github.com/user-attachments/assets/8debbbc6-3023-48ac-8571-dee182c890a1" /></td>
 <td><img width="960" height="489" alt="PBIDesktop_SSeXiwT4v3" src="https://github.com/user-attachments/assets/c7d409a5-986c-4f76-bd6d-e4c0d0a7fdb0" /></td>
  </tr>
</table>

---
 ```m
Calculated Columns DAX

Age_group = SWITCH(TRUE(),'public employees'[age]>=45,"45-50",'public employees'[age]>=36,"36-44",'public employees'[age]
>=25,"25-35",'public employees'[age]>=18,"18-24")


salary_check = SWITCH(TRUE(),'public hr_metrics'[salary_annual_inr]>RELATED('public role'[base_max]),"High_Pay",
    'public hr_metrics'[salary_annual_inr]<=RELATED('public role'[base_max]),"In_Range",
    'public hr_metrics'[salary_annual_inr]<=RELATED('public role'[base_min]),"Under_Pay")
 ```
* **Robust DAX Measures:** Wrote complex DAX measures for core KPIs, Time Intelligence, and conditional logic.

## 🎛️ 4. Dashboard Interactivity & UI
The dashboard is designed with a clean, corporate-level UI to offer a seamless experience:
* **Comprehensive Slicers:** Users can deeply filter the data using multiple slicers, including Age, Department, Salary Band, and Job Role.
* **Multi-Page Layout:** The report is logically divided into distinct sections (Executive Overview, Performance & Productivity, Impact Analysis) to guide the data narrative.

## 💡 5. Business Impact
This dashboard empowers HR teams and management to:
1. Instantly identify departments, roles, or age groups with the highest turnover rates.
2. Analyze the correlation between performance metrics, training hours, and employee retention.
3. Make proactive, data-driven decisions to improve workforce planning and optimize the business structure.

## 🛠️ Tech Stack & Skills Highlighted
* **Tool:** Power BI Desktop
* **Data Processing:** Power Query (M), ETL
* **Data Modeling:** Star Schema, Custom Date Tables
* **Calculations:** Advanced DAX (Time Intelligence, `USERELATIONSHIP`)
* **Advanced UI Features:** Field Parameters, Dynamic Visual Switching, Custom Slicers
