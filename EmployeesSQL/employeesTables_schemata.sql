--create titles table
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