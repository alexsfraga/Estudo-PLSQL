--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
--CRIANDO views


SELECT A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.SALARY,
    A.DEPARTMENT_ID,
    B.DEPARTMENT_NAME
    FROM HR.EMPLOYEES A
        INNER JOIN HR.departments B
            ON A.DEPARTMENT_ID=b.department_id;
            

--CRIANDO VIEW
CREATE OR REPLACE VIEW V_FUNC_DEPTO
    AS
    SELECT A.EMPLOYEE_ID,
            A.FIRST_NAME,
            A.SALARY,
            A.DEPARTMENT_ID,
            B.DEPARTMENT_NAME
        FROM HR.EMPLOYEES A
            INNER JOIN HR.departments B
                ON A.DEPARTMENT_ID=b.department_id;
                
SELECT * FROM V_FUNC_DEPTO
    WHERE DEPARTMENT_ID=20;
    
--ATUALIZANDO A VIEW
CREATE OR REPLACE VIEW V_FUNC_DEPTO
    AS
    SELECT A.EMPLOYEE_ID,
            A.FIRST_NAME,
            A.LAST_NAME "ULTIMO NOME",
            A.SALARY,
            A.DEPARTMENT_ID,
            B.DEPARTMENT_NAME
        FROM HR.EMPLOYEES A
            INNER JOIN HR.departments B
                ON A.DEPARTMENT_ID=b.department_id;
                
--TESTANDO A VIEW
SELECT * FROM V_FUNC_DEPTO;

-- CRIANDO OUTRA VIEW
CREATE OR REPLACE VIEW V_PAIS_REGIAO
    AS
    SELECT A.COUNTRY_ID,
            A.COUNTRY_NAME,
            A.REGION_ID,
            B.REGION_NAME
            FROM HR.countries A
                INNER JOIN HR.regions B
                ON a.region_id=b.region_id;
--TESTANDO A VIEW
SELECT * FROM v_pais_regiao
    WHERE REGION_NAME<>'Europe';
    
    
--REUTILIZANDO VIEW
SELECT region_name, COUNT(*) QTD 
    FROM v_pais_regiao
    GROUP BY region_name;
    
--REUTILIZANDO VIEW
CREATE OR REPLACE VIEW V_PAIS_LOCAL
    AS
    SELECT A.LOCATION_ID,
            A.CITY,
            B.COUNTRY_NAME
        FROM HR.locations A
            INNER JOIN V_PAIS_REGIAO B
            ON a.country_id=b.country_id;
            
--TESTE VIEW
SELECT a.COUNTRY_NAME, COUNT(*) qtd
    FROM V_PAIS_LOCAL a
    --where country_name like 'Brazil'
    GROUP BY COUNTRY_NAME;
    
select * from v_pais_local where country_name<>'Italy';

-- criando views com union all
create view v_depto_union
as
select a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY,a.DEPARTMENT_ID,b.DEPARTMENT_NAME
from HR.EMPLOYEES a
inner join hr.DEPARTMENTS b
on a.DEPARTMENT_ID=b.DEPARTMENT_ID
where a.DEPARTMENT_ID='10'

union all

select a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY,a.DEPARTMENT_ID,b.DEPARTMENT_NAME
from HR.EMPLOYEES a
inner join hr.DEPARTMENTS b
on a.DEPARTMENT_ID=b.DEPARTMENT_ID
where a.DEPARTMENT_ID='20'

union all
select a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY,a.DEPARTMENT_ID,b.DEPARTMENT_NAME
from HR.EMPLOYEES a
inner join hr.DEPARTMENTS b
on a.DEPARTMENT_ID=b.DEPARTMENT_ID
where a.DEPARTMENT_ID not in ('10','20');

-- usando a view
select * from v_depto_union;

-- criar view de historico de funcionario

-- verificando se algum funcionario nao tem historico

select * from HR.EMPLOYEES
where EMPLOYEE_ID not in (select EMPLOYEE_ID from HR.JOB_HISTORY);

--verificando os empregados tem historico
select * from HR.EMPLOYEES
where EMPLOYEE_ID  in (select EMPLOYEE_ID from HR.JOB_HISTORY);



select * from hr.JOB_HISTORY
where EMPLOYEE_ID='101'

select  * from HR.EMPLOYEES
where EMPLOYEE_ID='101';


-- criando a view de historico de funciorios/ usando union all
create or replace view v_hist_func
as
--selectionando informações do historico
select a.EMPLOYEE_ID,
       b.FIRST_NAME,
       a.START_DATE,
       a.END_DATE,
       a.JOB_ID,
       c.JOB_TITLE, 
       a.DEPARTMENT_ID,
       d.DEPARTMENT_NAME
from hr.JOB_HISTORY a
inner join hr.EMPLOYEES b
on a.EMPLOYEE_ID=b.EMPLOYEE_ID
inner join hr.JOBS c
on a.JOB_ID=c.JOB_ID
inner join HR.DEPARTMENTS d
on a.DEPARTMENT_ID=d.DEPARTMENT_ID
--where a.EMPLOYEE_ID='101'

union all

select a.EMPLOYEE_ID,
       a.FIRST_NAME,
       (select max(b.END_DATE)+1 from hr.JOB_HISTORY b
           where a.EMPLOYEE_ID=b.EMPLOYEE_ID)as START_DATE,
       sysdate END_DATE,
       a.JOB_ID,
       c.JOB_TITLE,
       a.DEPARTMENT_ID,
       d.DEPARTMENT_NAME
from hr.EMPLOYEES a
inner join hr.JOBS c
on a.JOB_ID=c.JOB_ID
inner join HR.DEPARTMENTS d
on a.DEPARTMENT_ID=d.DEPARTMENT_ID
--where a.EMPLOYEE_ID='101'
order by 1 asc,3 asc;

--consultando view
select * from v_hist_func
where EMPLOYEE_ID='101';





