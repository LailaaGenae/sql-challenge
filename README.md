# sql-challenge

## Background

## Objectives

## Data Modeling
Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables.

## Data Engineering
Create a table schema for each of the six CSV files. Specify the data types, primary keys, foreign keys, and other constraints.

```sql
-- create titles table
CREATE TABLE titles(
	title_id VARCHAR(7) PRIMARY KEY,
	title VARCHAR (33)
);

-- create departments table
CREATE TABLE departments(
	dept_no VARCHAR(55) PRIMARY KEY,
	dept_name VARCHAR(55)
);

-- create employees table
CREATE TABLE employees(
	emp_no int PRIMARY KEY ,
	emp_title_id VARCHAR(7) references titles(title_id),
	birth_date DATE,
	first_name VARCHAR(55),
	last_name VARCHAR(55),
	sex VARCHAR (1),
	hire_date DATE
);

-- create department employee table 
CREATE TABLE dept_emp(
	emp_no int references employees(emp_no),
	dept_no VARCHAR(222) references departments(dept_no)
);

-- create department manager table
CREATE TABLE dept_manager(
	dept_no VARCHAR(11) references departments(dept_no),
	emp_no int references employees(emp_no)
);

-- create salaries table
CREATE TABLE salaries(
	emp_no INT references employees(emp_no),
	salary INT
);
```

## Data Analysis
1. List the employee number, last name, first name, sex, and salary of each employee.

'''pgsql
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no;
'''
3. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-1-1' AND '1986-12-31'
ORDER BY hire_date ASC;

4. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name,  e.first_name
FROM dept_manager AS dm
JOIN employees as e ON e.emp_no = dm.emp_no
JOIN departments as d ON dm.dept_no = d.dept_no
ORDER BY d.dept_name ASC;

5. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
ORDER BY de.dept_no ASC;

6. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

7. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp as de 
JOIN employees as e ON de.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = de.dept_no WHERE d.dept_name = 'Sales';


8. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de 
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no 
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'

9. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, count(emp_no) as numEmployees_sharing_lastName
FROM employees
GROUP BY last_name 
ORDER BY numEmployees_sharing_lastName DESC;
