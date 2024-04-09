# sql-challenge

## Background
Research employees who worked for Pewlett Hackard (a fictional company) during the 1980s and 1990s using the 6 remaining CSV Files from that period.

## Objectives
Design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. 
perform: data modeling, data engineering, and data analysis.

## Data Modeling
Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables.

## Data Engineering
Create a table schema for each of the six CSV files. Specify the data types, primary keys, foreign keys, and other constraints.

```sql
--create titles table

CREATE TABLE titles(
	title_id VARCHAR(7) PRIMARY KEY,
	title VARCHAR (33) NOT NULL
);


-- create departments table
CREATE TABLE departments(
	dept_no VARCHAR(55) PRIMARY KEY,
	dept_name VARCHAR(55) NOT NULL
);


-- create employees table
CREATE TABLE employees(
	emp_no int PRIMARY KEY ,
	emp_title_id VARCHAR(7) references titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR(55) NOT NULL,
	last_name VARCHAR(55) NOT NULL,
	sex VARCHAR (1) NOT NULL,
	hire_date DATE NOT NULL
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
	salary INT NOT NULL
);

```

## Data Analysis
1. List the employee number, last name, first name, sex, and salary of each employee.

```sql
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no;
```
2. List the first name, last name, and hire date for the employees who were hired in 1986.
```sql
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-1-1' AND '1986-12-31'
ORDER BY hire_date ASC;
```
3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
```sql
SELECT dm.dept_no, d.dept_name, e.emp_no, e.last_name,  e.first_name
FROM dept_manager AS dm
JOIN employees as e ON e.emp_no = dm.emp_no
JOIN departments as d ON dm.dept_no = d.dept_no
ORDER BY d.dept_name ASC;
```
4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
```sql
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
ORDER BY de.dept_no ASC;
```
5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
```sql
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
```
6. List each employee in the Sales department, including their employee number, last name, and first name.
```sql
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp as de 
JOIN employees as e ON de.emp_no = e.emp_no
JOIN departments as d ON d.dept_no = de.dept_no WHERE d.dept_name = 'Sales';
```
7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
```sql
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp AS de 
JOIN employees AS e ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no 
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
```
8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
```sql
SELECT last_name, count(emp_no) as numEmployees_sharing_lastName
FROM employees
GROUP BY last_name 
ORDER BY numEmployees_sharing_lastName DESC;
```
