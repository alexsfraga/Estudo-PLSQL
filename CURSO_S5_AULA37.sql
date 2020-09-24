--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- funções de controle de fluxo, que são a CASE e a NULLIF
-- exemplo função CASE
select a.first_name, a.salary,
    CASE WHEN a.salary<5000 then 'baixo'
        when a.salary <10000 then 'Medio'
        when a.salary <15000 then 'Medio Alto'
        ELSE 'ALto' 
        END FAIXA
    from hr.employees a
    order by a.salary desc;
    
select a.first_name, a.salary,
    CASE WHEN a.salary<5000 then 'baixo'
        when a.salary >=5000 AND a.salary <10000 then 'Medio'
        when a.salary >=1000 AND a.salary <15000 then 'Medio Alto'
        ELSE 'ALto' 
        END FAIXA
    from hr.employees a
    order by a.salary desc;

--exemplo CASE
select a.first_name, a.manager_id,
    CASE 
        when a.manager_id is null then 'Gerente'
        else 'Subordinado' END HIERARQ
        from hr.employees a;

select a.employee_id,
        a.first_name,
        a.manager_id,
        b.first_name
        from hr.employees a
            left join hr.employees b
            ON a.manager_id=b.manager_id
            order by a.employee_id;
            
select * from hr.locations;

select UNIQUE country_id,
    Case country_id
        when 'AU' then 'australia'
        when 'BR' then 'brasil'
        when 'CA' then 'canada'
        when 'CH' then 'switzerland'
        when 'CN' then 'china'
        when 'DE' then 'germany'
        when 'IN' then 'india'
        when 'IT' then 'italy'
        when 'JP' then 'japan'
        when 'MX' then 'mexico'
        when 'NL' then 'netherland'
        when 'SG' then 'singapore'
        when 'UK' then 'united kingdom'
        when 'US' then 'united states'
    ELSE 'Outros'
    END Country
From hr.locations
order by country_id;

select a.first_name, a.commission_pct,
    case when a.commission_pct is not null then 'Vendedor'
    Else 'Interno' END Hierarq
    from hr.employees a;
    
--exemplo NULLIF, retorna NULL se o valor comparado for igual
select NULLIF(100,10) from dual;

-- exemplo que NULLIF não serve para tratar retorno NULL
select a.first_name,
    a.commission_pct, 
    NULLIF(a.commission_pct,0)
    from hr.employees a;
        

        
        
        
        
        