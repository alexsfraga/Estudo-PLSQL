--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- funções de agregação
-- AVG, MIN, MAX, SUM, COUNT, STDDEV, VARIANCE

select * from senso;

-- avg retorna media dos valores em um grupo. valores nulos sao ignorados
select avg(populacao) as media from senso where ano=2014;

--avg media por estado
select estado, avg(populacao) 
    from senso 
        where ano=2014
        group by estado
        order by 2 desc;

-- AVG MEDIA POR ESTADO COM SIGLA ESTADO
select  a.cod_uf, b.sigla_uf, avg(a.populacao) media
        from senso a
            inner join uf b ON a.cod_uf=b.cod_uf
        where a.ano=2014
        group by a.cod_uf, b.sigla_uf
        order by 3 desc;
        
-- avg por regiao media por regiao
select a.regiao, avg(a.populacao)
    from senso a
    where a.ano=2014
    group by a.regiao
    order by 2 desc;

--min retorno o valor minimo das expressao. Pode ser seguido pela clausula OVER
select min(a.populacao) from senso a
    where a.ano=2014;
    
-- min por estado
select a.estado, min(a.populacao) menor_Pop
    from senso a
    where a.ano=2014
    group by estado, a.estado;
    
-- min por regiao
select a.regiao, min(populacao)
    from senso a
    where a.ano=2014
    group by a.regiao
    order by 2 asc;
    
-- max retorna o valor maximo na expressao
select max(populacao)
    from senso a
    where a.ano=2014;
    
-- Max por estado
select a.estado, max(a.populacao)
    from senso a
    where a.ano=2014
    group by a.estado
    order by 2 desc;

-- max por sigla do estado
select b.sigla_uf, max(a.populacao)
    from senso a
    inner join uf b 
        ON a.cod_uf=b.cod_uf
    where a.ano=2014
    group by b.sigla_uf
    order by 2 asc;
    
-- sum por estado
select a.cod_uf, sum(a.populacao)
    from senso a
    where a.ano=2014
    group by a.cod_uf
    order by 2;
    
-- sum por regiao
select b.sigla_uf, sum(a.populacao) as maximo
    from senso a
        inner join uf b
            ON a.cod_uf=b.cod_uf
    where a.ano=2014
    group by b.sigla_uf
    order by 2;
    
--COUNT  retorna o numero de elementos de um grupo
select count(*) from senso a
    where a.ano=2014;
    
-- count por ano o numero de cidades
select a.ano, count(*) qtd_cidades
from senso a
    group by a.ano
    order by 1 asc;
    

