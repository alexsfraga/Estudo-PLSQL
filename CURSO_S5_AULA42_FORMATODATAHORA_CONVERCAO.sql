--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- FUNÇÕES DE CONVERSAO

-- usando cast ele converte e acaba arrendondando o valor por ser de tipos diferentes
select CAST(1932.450 as integer) conversao from dual;
select CAST(1932.650 as integer) conversao from dual;

select CAST(a.employee_id as integer) teste from hr.employees a;

select cast(a.employee_id as varchar2(3))teste from HR.employees a;


-- funcao TO_DATE()
--criando uma mascara 
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';
alter session set nls_date_format='yy-mm-dd hh24:mi:ss';

select a.hire_date,
    to_date(a.hire_date,'yyyy-mm-dd hh24:mi:ss')aaaammdd
    from HR.employees a;
    
-- TO_CHAR(data)
-- TO_CHAR(data, mascara_data,[mls_date_format])
alter session set nls_territory='PORTUGAL';
alter session set nls_language='PORTUGUESE';
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

select a.first_name,
    a.hire_date,
    to_char(A.hire_date,'day, dd "de" Month "de" yyyy')Data_extenso
    from hr.employees a;
    
select to_char(sysdate,'day, dd "de" Month "de" yyyy')Data_systema from dual;

-- to_char
alter session set nls_territory='PORTUGAL';
alter session set nls_language='PORTUGUESE';
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

select
    to_char(to_date('2018-07-17 12:15:45','yyyy-mm-dd hh24:mi:ss'),'hh:mi:ss') "Hora Minutos Segundos",
    to_char(to_date('2018-07-17 12:15:45','yyyy-mm-dd hh24:mi:ss'),'scc') "Seculo",
    to_char(to_date('2018-07-17 12:15:45','yyyy-mm-dd hh24:mi:ss'),'q') "Trimestre",
    to_char(to_date('2018-07-17 12:15:45','yyyy-mm-dd hh24:mi:ss'),'HH24') "Hora formato 24 horas",
    to_char(to_date('2018-07-17 12:15:45','yyyy-mm-dd hh24:mi:ss'),'HH') "Hora formato 12 horas"
    from dual;
    
-- TO_CHAR(numero)
select a.first_name,
    a.hire_date,
    a.salary salario,
    to_char(a.salary,'$9999999')salario1,
    to_char(a.salary,'$999')salario2,
    '$ '||a.salary valor
    from hr.employees a;
    
--TO_NUMBER(string)
select to_number('5')+7 v
    from dual;
    
select to_char(sysdate,'ddmmyyyyhh24miss') from dual;

--NVL() quando o valor do campo é NULL ele adiciona o valor especificado no local da consulta.
select  a.first_name,
        a.hire_date,
        a.commission_pct,
        nvl(a.commission_pct,0) c1
        from hr.employees a;