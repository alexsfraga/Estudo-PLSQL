--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- FUNCAO LIMITE

-- tazer os 5 maiores dentro da base
SELECT * FROM hr.employees a
    where rownum<=5
    order by a.salary desc;
    
SELECT a.employee_id,
        a.first_name,
        a.salary,
        b.department_name
    FROM hr.employees a
        inner join HR.departments b
            ON a.department_id = b.department_id
    where a.department_id=60 and  rownum<=10
    order by a.salary desc;