--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- SUBSELECTS

select * from HR.employees;
select * from HR.job_history;
select * from HR.departments;
select * from hr.jobs;

-- exemplo subselect operador IN
select * from HR.employees a 
    where a.employee_id 
        IN ( select b.employee_id from HR.job_history b);
        
select * from HR.employees a
    where a.manager_id=100
    and a.employee_id in (select b.employee_id from HR.job_history b);

-- exemplo subselect operador IN e clausula WHERE dentro do subselect
select * from HR.employees a
    where a.employee_id in (
                select b.employee_id from HR.job_history b
                    where b.department_id=50);
                    
select * from hr.job_history b where b.department_id=50;

-- exemplo subselect operador NOT IN 
select * from hr.employees a 
    where a.employee_id NOT IN (
                select b.employee_id from hr.job_history b);

select * from hr.employees a
    where a.employee_id
    NOT IN (select b.employee_id from hr.job_history b
                where b.department_id=50);
    

select * from hr.employees a
    where a.department_id=50 NOT IN (
                select b.employee_id from hr.job_history b);

-- subselect trazendo COLUNA

select a.employee_id,
        a.first_name,
        a.job_id,
        (select b.job_title from hr.jobs b where a.job_id=b.job_id)
        from hr.employees a;

select a.employee_id,
        a.first_name,
        a.department_id,
        (select b.department_name from hr.departments b where a.department_id=b.department_id) as Depto
        from hr.employees a;

select a.department_id,
        a.department_name,
        a.manager_id,
        (select b.first_name from hr.employees b
                where a.manager_id=b.employee_id) as gerente
        from hr.departments a;
        
--select com valor agregado soma
select a.department_id,
        a.department_name,
        (select sum(b.salary) from hr.employees b
                where a.department_id=b.department_id) as salario_dpto
        from hr.departments a;

select a.department_id,
        a.department_name,
        (select sum(b.salary) from hr.employees b
                where a.department_id=b.department_id) salario_dpto,
        (select count(*) from hr.employees b
                where a.department_id=b.department_id) qtd_func
        from hr.departments a;
        
select a.department_id,
        a.department_name,
        (select sum(b.salary) from hr.employees b
                where a.department_id=b.department_id) salario_dpto,
        (select count(*) from hr.employees b
                where a.department_id=b.department_id) qtd_func,
        --selec com operador matematico divisao
        (select sum(b.salary) from hr.employees b where a.department_id=b.department_id)
         / (select count(*) from hr.employees b where a.department_id=b.department_id) media_salary
        from hr.departments a;













--exemplo innert Join
    select a.employee_id,
       a.first_name as nome,
       c.job_title as funcao,
       b.department_name as departamento,
       d.first_name as gerente
       from hr.employees a
       inner join jobs c ON a.job_id=c.job_id
       inner join departments b ON a.department_id=b.department_id
       inner join (select employee_id, first_name from hr.employees) d 
                    ON a.manager_id = d.employee_id;
                    
select a.employee_id,
       a.first_name as nome,
       c.job_title as funcao,
       b.department_name as departamento,
       d.first_name as gerente
       from hr.employees a
       inner join jobs c ON a.job_id=c.job_id
       inner join departments b ON a.department_id=b.department_id
       inner join (select * from employees) d 
                    ON a.manager_id = d.employee_id;
                    
-- exemplo inner joi e select na Coluna        
select a.employee_id,
       a.first_name as nome,
       c.job_title as funcao,
       b.department_name as departamento,
       (select d.first_name from hr.employees d where a.manager_id=d.employee_id) as gerente
       from hr.employees a
       inner join jobs c ON a.job_id=c.job_id
       inner join departments b ON a.department_id=b.department_id;
       