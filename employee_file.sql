Create table departments(
dept_no varchar(10) primary key,
dept_name varchar(255)
);
select * from departments
create table dept_employees(
emp_no varchar(10),
dept_no varchar(10)
);

create table dept_manager(
dept_no varchar(10),
emp_no varchar(10)primary key,
FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

create table employees(
emp_no varchar(10) primary key,
emp_title varchar(10),
birth_date date,
first_name varchar(64),
last_name varchar(64),
sex varchar(5),
hire_date date,
foreign key (emp_title) REFERENCES titles(title_id)
);
select * from employees
create table salaries(
emp_no varchar(10),
salary int,
foreign key (emp_no) REFERENCES employees(emp_no)
);

create table titles(
title_id varchar(10) primary key,
title varchar(64)
);

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
Select e.emp_no as Employee_Id, e.first_name, e.last_name, e.sex, s.salary
from employees e
INNER JOIN salaries s
	ON s.emp_no = e.emp_no
	
--2. List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, extract(year from hire_date)
from employees
where extract(year from hire_date) >= 1986

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
Select d.dept_no as Department_Number, d.dept_name, e.emp_no as Employee_Number, e.last_name, e.first_name
from departments d
INNER JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
INNER JOIN employees e
	ON e.emp_no = dm.emp_no

--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
Select e.emp_no as Employee_Number, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_employees de
	ON e.emp_no = de.emp_no
INNER JOIN departments d
	ON de.dept_no = d.dept_no
	
--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex from employees
where first_name = 'Hercules'
and last_name Ilike 'B%'

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no as Employee_Number, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_employees de
	ON e.emp_no = de.emp_no
INNER JOIN departments d
	ON de.dept_no = d.dept_no
where dept_name = 'Sales'

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select e.emp_no as Employee_Number, e.last_name, e.first_name, d.dept_name
from employees e
INNER JOIN dept_employees de
	ON e.emp_no = de.emp_no
INNER JOIN departments d
	ON de.dept_no = d.dept_no
where dept_name = 'Development'

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count(last_name) from employees e
group by last_name
order by count(last_name) desc