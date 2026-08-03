
--Creat_tables_&_import_data_into_SQL 
create table department(
	dept_id	varchar(50)	primary key,
dept_name	varchar(50)	not null,
location	varchar(50)	not null,
dept_head	varchar(50)	not null
);
select * from department;

create table role(
role_id	varchar(20)	primary key,
role_name	varchar(50)	not null, 
band	varchar(10)	not null, 
base_min	decimal(10,2)	not null, 
base_max	decimal(10,2)	not null 
);

create table employees(
employee_id	varchar(50)	primary key,
full_name	varchar(50)not null,	
gender	varchar(20),
date_of_birth	date,	
hire_date	date,	
dept_id	varchar(20)	not null,
role_id	varchar(20)	not null,
education	varchar(40)	,
marital_status	varchar(20)	
);

create table hr_metrics(
employee_id	varchar(50)	primary key,
dept_id	varchar(20)	not null,
role_id	varchar(20)	not null,
band	varchar(20)	not null,
salary_annual_inr	decimal(10,2)	not null,
performance_2023	smallint,	
performance_2024	smallint,	
years_at_company	decimal(10,2),	
years_in_current_role	decimal(10,2),	
attrition	text,	
attrition_date	date,	
attrition_reason	text,	
promotion_last_2yrs	text,	
training_count_2024	smallint,	
training_hours_2024	int,	
job_satisfaction	smallint,	
work_life_balance	smallint,	
overtime_hours_monthly	smallint	
);


 select * from hr_metrics;
 
 select * from role;

 select * from employees
 where employee_id = 'EMP0362';

 select * from department;
 select max(attrition_date)from hr_metrics;
 
--Cleaning_&_alter_data_steps
---add column age 
 alter table employees
 add column age smallint;

--fill the column age
---using extract only years
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

---using CTEs & extract only years
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

 select * from employees
 where employee_id='EMP0490';
 
  select * from hr_metrics where employee_id='EMP0010';
  
---checking data & analysis
  select e.employee_id,e.age,e.working_years as e_years,
  h.years_at_company as years,h.promotion_last_2yrs,
  h.attrition from employees e left join hr_metrics h
  on e.employee_id=h.employee_id order by e.employee_id; 

--updateing_data in hr_metrics
 update hr_metrics
  set years_at_company = null;
  
--alter column year_at_company in hr_metrics
  alter table hr_metrics
  alter column years_at_company type varchar(50);
  
---add data in year_at_company column
update hr_metrics
set years_at_company =(select working_years from 
employees where employees. employee_id=hr_metrics. employee_id);

---checking data & analysis

select * from hr_metrics;
select years_at_company,years_in_current_role,case 
when
(years_in_current_role::char) > years_at_company
then 'no'else'ok' end as checked from hr_metrics;


---cleaning process & analysis

update hr_metrics
set years_in_current_role=extract(year from age((select max(attrition_date)from hr_metrics),
(select hire_date from employees)))
where years_in_current_role='0.00';

alter table hr_metrics
alter column years_in_current_role type varchar(20);

select * from hr_metrics ;
where years_in_current_role='0.00';


---add column working_years in hr_metrics

alter table hr_metrics 
add column working_years varchar(10);

 select * from hr_metrics;

---add data in column working_years 

update hr_metrics h
set working_years= extract(year from age((select max(attrition_date)
from hr_metrics),(select hire_date from employees e 
where e.employee_id=h.employee_id)));

---data checking & analysis

select employee_id,years_at_company,working_years from 
hr_metrics order by employee_id;


select * from department;
select * from employees;
select * from role;
select * from hr_metrics;

---alter column attrition_check

alter table hr_metrics rename
column attriation_check to attrition_check;

---fill data into column attrition_check

update hr_metrics
set attrition_check=case
when Lower(attrition) 
='no'then 0 else 1 end ;

select count(attrition)
from hr_metrics where lower(attrition) ='no';

select*from hr_metrics order by employee_id;

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

--1)Total_employees

---total_employees
select distinct count(employee_id)as Total_employees from employees;

----total_attrition employees

---i)methode one
select count(attrition)as attrition_emp from hr_metrics
where lower(attrition)='yes';
---i)methode two
select sum(attrition_check)as attrition_emp from hr_metrics;

--total_emp,attrition,total_working_emp,attrition percentage

select count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(h.attrition_check)::numeric/count(e.employee_id)::numeric*100)::decimal(10,2) ||'%'as attrition_percentage
from employees e left join
hr_metrics h on e.employee_id=h.employee_id;

--employees count by hire date
select hire_date as hire_date,count(employee_id)as total_emp 
from employees group by hire_date;

---ii)total_employees by gender 

select e.gender,count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(attrition_check)::numeric/count(e.employee_id)::numeric * 100)::decimal(10,2)||'%'
as attrition_percentage
from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by gender;

--total_employees by education analysis

select e.education,count(e.employee_id)as total_employees,sum(h.attrition_check)as attrition_count,
count(e.employee_id)-sum(h.attrition_check)as total_working_employees,
(sum(attrition_check)::numeric/count(e.employee_id)::numeric * 100)::decimal(10,2)||'%'
as attrition_percentage
from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by e.education;

--ii)count of employees by age

select e.age,count(e.employee_id)as total_employees,
sum(h.attrition_check)as attrition_count, count(e.employee_id)-sum(attrition_check)
as total_working_employees,cast(sum(h.attrition_check)::numeric/count(e.employee_id)::numeric*100 as decimal(10,2))||'%'
as attrition_percentage from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by e.age;

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

--count of employees by marital_status
select e.marital_status,count(e.employee_id)as total_employees,
sum(h.attrition_check)as attrition_count, count(e.employee_id)-sum(attrition_check)
as total_working_employees,cast(sum(h.attrition_check)::numeric/count(e.employee_id)::numeric*100 as decimal(10,2))||'%'
as attrition_percentage from employees e left join hr_metrics h on
e.employee_id=h.employee_id
group by e.marital_status;

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

--count of employees by band
with
employees as
(select r.band,count(e.employee_id)as total_employees from role r left join
employees e on r.role_id=e.role_id group by r.band),
attrition as
(select r.band,sum(h.attrition_check)as attrition from role r left join
hr_metrics h on r.role_id=h.role_id group by r.band)
select e.band,e.total_employees,a.attrition,e.total_employees-a.attrition as
total_working_emp,cast(a.attrition::numeric/e.total_employees::numeric*100 as decimal(10,2))||'%'
as attrition_percentage from employees e left join attrition a on e.band=a.band
order by e.band;

select * from hr_metrics;
--datewise attrition count
select attrition_date,sum(attrition_check) as attrition
from hr_metrics group by attrition_date;

--attrition count by years_at_company

select years_at_company,sum(attrition_check) as attrition from hr_metrics
 group by years_at_company having sum(attrition_check)<>0;

 --attrition by promotions
select promotion,sum(attrition_check) as attrition
from hr_metrics group by promotion;

---attrition count by reason
select attrition_reason,sum(attrition_check)  as attrition from hr_metrics
group by attrition_reason having sum(attrition_check)<>0 order by sum(attrition_check);

---attrition count by working_years
select working_years,sum(attrition_check)  as attrition from hr_metrics
group by working_years;

select*from hr_metrics;
select*from role;

select r.role_id,r.role_name,r.band,sum(h.salary_annual_inr) as salary,
sum(r.base_min) as min_salary,sum(r.base_max)as max_salary from role r left join hr_metrics h on
r.role_id=h.role_id group by r.role_id;


---salary compresion
----department wise salery 
---attrition employees

---department wise salery check with salary_pay_range
with
depart_sa as
(select d.dept_id,d.dept_name,d.dept_head,sum(h.salary_annual_inr)as salary from department d
left join hr_metrics h on d.dept_id=h.dept_id group by d.dept_id),
role_sa as
(select r.role_id,r.role_name,r.band,h.dept_id,r.base_min,r.base_max from
role r left join hr_metrics h on r.role_id=h.role_id group by r.role_id,h.dept_id)

select d.dept_id,d.dept_name,d.dept_head,sum(r.base_min)as min,
sum(r.base_max) as max,sum(d.salary)as actual_salary,
 case when
sum(d.salary) between sum(r.base_max) and sum(r.base_min) then 'in range'
when sum(d.salary)<sum(r.base_min) then 'underpaid'
else 'overpaid'end as salary_check,
case
when sum(d.salary)>sum(r.base_max) then 'high'else'not'end as salary_pay
from depart_sa d left join role_sa r on
d.dept_id=r.dept_id group by d.dept_id,d.dept_name,d.dept_head;


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

select d.dept_id,d.dept_name,d.dept_head,sum(r.min_salary) as min,
sum(r.max_salary)as max,sum(d.actual_salary)as actual_salary,
case
 when sum(d.actual_salary) between sum(r.max_salary) and 
sum(r.min_salary) then 'underrange' when sum(d.actual_salary)<sum(r.min_salary) then
'unnder_paid' else 'overpaid'end as salary_cheking
 from dep d left join
ran r on d.dept_id=r.dept_id group by d.dept_id,d.dept_name,d.dept_head;

---role wise salery check 
select r.role_id,r.role_name,r.band,r.base_min,r.base_max,sum(h.salary_annual_inr) as actual_salary,
case when
 sum(h.salary_annual_inr) between r.base_max and r.base_min then 'in range'
when sum(h.salary_annual_inr)<r.base_min then 'under paid' else 'over paid' end as checking
 from role r left join hr_metrics h on trim(r.role_id)=trim(h.role_id)
group by r.role_id,r.role_name,r.band order by r.role_id;



select*from department;
select*from role;
select*from employees;
select*from hr_metrics;

create view employees_data as 
with
salary as
(select e.employee_id,e.full_name,e.gender,e.dept_id,r.role_id,r.role_name,r.band,
e.education,e.marital_status,e.age,e.working_years,r.base_min as min_salary,
r.base_max as max_salary from employees e left join role r on 
e.role_id=r.role_id order by e.employee_id)
select s.employee_id,s.full_name,s.gender,s.dept_id,s.role_id,s.role_name,s.band,
s.education,s.marital_status,s.age,s.working_years,s.min_salary,s.max_salary,h.salary_annual_inr,
case when
 h.salary_annual_inr between s.max_salary and s.min_salary then 'in_range'
when
 h.salary_annual_inr<s.min_salary then 'under_pay' else 'over_pay' end as salary_check,
h.performance,h.years_at_company,h.attrition,h.attrition_date,h.attrition_reason,
h.promotion,h.training_count,h.training_hours,h.job_satisfaction,
h.work_life_balance,h.overtime_hours_monthly,h.working_years as years_in_company,h.attrition_check
from salary s left join hr_metrics h on s.employee_id=h.employee_id; 

select*from employees_data;
where lower(attrition)='yes';

---genderwise salary check
select gender,sum(min_salary)as min_salary,sum(max_salary)as max_salary,
sum(salary_annual_inr)as salary,salary_check from employees_data group by gender, salary_check;

---genderwise salary check & data 
select gender,sum(min_salary)as min_salary,sum(max_salary)as max_salary,
sum(salary_annual_inr)as salary,
case when 
sum(salary_annual_inr) between sum(max_salary)
and sum(min_salary) then 'in_range'
when sum(salary_annual_inr)<sum(min_salary) then 'under_pay' else 'over_pay' end as salary_check,
avg(performance)::decimal(10,2) as avg_performance,avg(training_count)::decimal(10,2)as avg_training_count,
avg(training_hours)::decimal(10,2)as avg_training_hours,avg(job_satisfaction)::decimal(10,2)as avg_job_satisfaction,avg(work_life_balance)::decimal(10,2)
as avg_work_life_balance,avg(overtime_hours_monthly)::decimal(10,2)as avg_overtime_hours_monthly,count(employee_id) as
employees,sum(attrition_check)as employees_attrition,count(employee_id)-sum(attrition_check)as working_employees
from employees_data where lower(attrition)='yes' group by gender;

---department_wise salary check & data 
select dept_id,role_id,sum(min_salary)as min_salary,sum(max_salary)as max_salary,
sum(salary_annual_inr)as salary,
case when
 sum(salary_annual_inr) between sum(max_salary)
and sum(min_salary) then 'in_range'
when sum(salary_annual_inr)<sum(min_salary) then 'under_pay' else 'over_pay' end as salary_check,
avg(performance)::decimal(10,2) as avg_performance,avg(training_count)::decimal(10,2)as avg_training_count,
avg(training_hours)::decimal(10,2)as avg_training_hours,avg(job_satisfaction)::decimal(10,2)as avg_job_satisfaction,avg(work_life_balance)::decimal(10,2)as
avg_work_life_balance,avg(overtime_hours_monthly)::decimal(10,2)as avg_overtime_hours_monthly,count(employee_id) as
employees,sum(attrition_check)as employees_attrition,count(employee_id)-sum(attrition_check)as working_employees
from employees_data where lower(attrition)='yes' group by dept_id,role_id;

--role wise salary check & data 

select role_id,role_name,band,sum(min_salary)as min_salary,sum(max_salary)as max_salary,
sum(salary_annual_inr)as salary,
case when
 sum(salary_annual_inr) between sum(max_salary)
and sum(min_salary) then 'in_range'
when sum(salary_annual_inr)<sum(min_salary) then 'under_pay' else 'over_pay' end as salary_check,
avg(performance)::decimal(10,2) as avg_performance,avg(training_count)::decimal(10,2)as avg_training_count,
avg(training_hours)::decimal(10,2)as avg_training_hours,avg(job_satisfaction)::decimal(10,2)as avg_job_satisfaction,avg(work_life_balance)::decimal(10,2)
as avg_work_life_balance,avg(overtime_hours_monthly)::decimal(10,2)as avg_overtime_hours_monthly,count(employee_id) as
employees,sum(attrition_check)as employees_attrition,count(employee_id)-sum(attrition_check)as working_employees
from employees_data where lower(attrition)='yes' group by role_id,role_name,band;

--age wise salary check & data 
select age,years_in_company,sum(min_salary)as min_salary,sum(max_salary)as max_salary,
sum(salary_annual_inr)as salary,case when 
sum(salary_annual_inr) between sum(max_salary)
and sum(min_salary) then 'in_range'
when sum(salary_annual_inr)<sum(min_salary) then 'under_pay' else 'over_pay' end as salary_check,
avg(performance)::decimal(10,2) as avg_performance,avg(training_count)::decimal(10,2)as avg_training_count,
avg(training_hours)::decimal(10,2)as avg_training_hours,avg(job_satisfaction)::decimal(10,2)as avg_job_satisfaction,avg(work_life_balance)::decimal(10,2)as
avg_work_life_balance,avg(overtime_hours_monthly)::decimal(10,2)as avg_overtime_hours_monthly,count(employee_id) as
employees,sum(attrition_check)as employees_attrition,count(employee_id)-sum(attrition_check)as working_employees
from employees_data where lower(attrition)='yes' group by age,years_in_company;
