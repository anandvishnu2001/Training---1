SELECT * FROM employees;

SELECT salary FROM employees;

SELECT DISTINCT job_name FROM employees;

SELECT emp_name, CONCAT('$', ROUND(salary*1.15)) AS Salary FROM employees;

SELECT CONCAT(emp_name,SPACE(10),job_name) AS 'Employee \& Job' FROM employees;

SELECT emp_id, emp_name, salary, DATE_FORMAT(hire_date, '%M %d,%Y') AS to_char FROM employees;

SELECT LENGTH(emp_name) AS length FROM employees;

SELECT emp_id, salary, commission FROM employees;

SELECT * FROM employees WHERE dep_id NOT IN (2001);

SELECT * FROM employees WHERE YEAR(hire_date) < 1991;

SELECT AVG(salary) AS avg FROM employees WHERE job_name = 'ANALYST';

SELECT * FROM employees WHERE emp_name = 'BLAZE';

SELECT * FROM employees WHERE salary*1.25 > 3000;

SELECT * FROM employees WHERE MONTH(hire_date) = 1;

SELECT emp_id, emp_name, hire_date, salary FROM employees WHERE hire_date<'1991-04-01';

SELECT emp_name, salary FROM employees, salary_grade WHERE (salary BETWEEN min_sal AND max_sal) AND emp_name = 'FRANK';

SELECT * FROM employees WHERE job_name NOT IN ('PRESIDENT','MANAGER') ORDER BY salary;

SELECT MAX(salary) AS max FROM employees;

SELECT job_name, AVG(salary), AVG(salary + commission) FROM employees GROUP BY job_name;

SELECT e.emp_id, e.emp_name, e.dep_id, d.dep_location, d.dep_name FROM employees AS e, department AS d WHERE e.dep_id = d.dep_id AND e.dep_id IN (1001,2001);

SELECT  manager_id, COUNT(manager_id) AS count FROM employees GROUP BY manager_id HAVING count > 0 ORDER BY manager_id;

SELECT dep_id, COUNT(emp_id) AS count FROM employees GROUP BY dep_id HAVING count > 2;

SELECT * FROM employees WHERE emp_name LIKE '%AR%';

ALTER TABLE employees ADD COLUMN (gender VARCHAR(6));

UPDATE employees 
SET 
    gender = (CASE
        WHEN emp_name IN ('KAYLING','BLAZE','JONAS','FRANK','WADE','TUCKER','JULIUS','MARKER') THEN 'Male'
        WHEN emp_name IN ('CLARE','SCARLET','SANDRINE','ADELYN','MADDEN','ADNRES') THEN 'Female'
    END);

SELECT * FROM employees WHERE job_name NOT IN ('PRESIDENT','MANAGER');

SELECT 
    DISTINCT job_name,
    CASE
        WHEN
            job_name IN ('PRESIDENT','MANAGER','ANALYST')
        THEN
            'MANAGEMENT-LEVEL'
        WHEN
            job_name IN ('SALESMAN','CLERK')
        THEN
            'EMPLOYEE-LEVEL'
    END AS level
FROM
    employees;

UPDATE employees SET commission = 650.00 WHERE EXISTS (SELECT * FROM employees WHERE job_name = 'ANALYST');

UPDATE employees SET commission = 650.00 WHERE job_name = 'ANALYST';