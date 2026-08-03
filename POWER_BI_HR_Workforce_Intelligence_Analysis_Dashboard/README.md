# HR_Workforce-Intelligence-Analysis-Project
End-to-End Strategic HR Workforce Intelligence Analysis | SQL Server • Power BI • Excel Power Pivot. SQL data cleaning, Star Schema architecture for data modeling, complex DAX measures and 4 Interactive dashboards delivering visibility into headcount, turnover, diversity and workforce performance to drive data-driven decisions.


# 📊 HR Workforce Intelligence Dashboard (Power BI)

![Dashboard Screenshot](replace_with_your_power_bi_dashboard_image_link_here.png)
*Caption: Executive Overview of the HR Workforce Intelligence Dashboard.*

## 📌 Project Overview
This project is an advanced, interactive Power BI dashboard designed to analyze HR metrics, track workforce demographics, and uncover the root causes of employee attrition. Building upon a structured SQL database, this dashboard transforms raw HR data into actionable business intelligence.

The primary objective of this project is to showcase advanced Power BI capabilities, including complex data modeling, dynamic DAX calculations, and interactive reporting tailored for executive decision-making.

## ⚙️ 1. Data Extraction & Power Query (ETL)
Data was initially stored in a database environment. I established a connection to import the core tables: `hr_metrics`, `employees`, `department`, and `role`. 
Using **Power Query**, I performed data shaping, applied necessary transformations, and ensured data types were fully optimized for the semantic model.

## 🗂️ 2. Data Modeling & Star Schema
A highly optimized data model is the backbone of this dashboard. 
* **Star Schema:** I structured the data using a Star Schema methodology to ensure fast query performance and intuitive relationship management.
* **Date Table:** I generated a comprehensive, custom Date Table to unlock powerful Time Intelligence capabilities across the dataset.
* **Advanced Relationships (`USERELATIONSHIP`):** The model required complex relationship structures. To handle multiple date filters and dimensions, I managed inactive relationships effectively using the `USERELATIONSHIP` DAX function, ensuring accurate calculations without compromising model integrity.

## 🧮 3. Advanced DAX & Dynamic Visuals
To make the dashboard highly interactive and insightful, I utilized several advanced Power BI features with the help of AI for optimization:
* **Field Parameters for Dynamic Reporting:** I implemented Field Parameters to give the end-user ultimate control. Through a single slicer, users can dynamically switch the metrics displayed across the dashboard's visuals (e.g., instantly toggling the charts to analyze 'Total Employees' vs. 'Attrition Employees').
* **Calculated Columns:** Created strategic calculated columns to categorize and segment data effectively (e.g., creating custom Age Groups and Work Experience bands).
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
