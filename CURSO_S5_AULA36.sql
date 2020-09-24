--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
--fUNÇÕES DE CLASSIFICAÇÃO

-- ROW_NUMBER()
select row_number() over (order by a.salary desc) Sequancia,
        a.first_name,
        a.salary,
        NTILE(2) over (order by a.salary desc) faixa
        from hr.employees a
        order by a.salary desc;
        
-- usando RANK()
select rank() over (order by a.salary desc) classificacao,
        a.first_name,
        a.salary
        from hr.employees a
        order by a.salary desc;
        
--exemplo RANK() e o DENSE_RANK()
select RANK() over (order by a.salary desc) classif_geral,
        DENSE_RANK() over (order by a.salary desc) classif_densa,
        a.first_name,
        a.salary,
        a.job_id
        from hr.employees a
        order by a.salary desc;

select RANK() over (order by a.salary desc) classif_geral,
        RANK() OVER(partition by a.job_id order by a.salary desc) classif_geral2,
        a.first_name,
        a.salary,
        a.job_id
        from hr.employees a
        order by a.salary desc;
        
-- exemplo com NTILE() ntile divide em grupos de n elementos
select a.job_title,
        a.max_salary,
        NTILE(5) OVER(ORDER BY a.max_salary desc) Faixa
        from hr.jobs a;
        
select a.first_name,
        a.salary,
        NTILE(4) OVER(ORDER BY a.salary desc) Faixa
        from hr.employees a
        order by a.salary desc;