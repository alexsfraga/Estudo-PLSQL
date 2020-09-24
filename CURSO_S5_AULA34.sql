--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/

-- DESCOBRINDO QTD ESTADO
SELECT COUNT(DISTINCT COD_UF) FROM SENSO;

--EXEMPLO
SELECT COUNT(COD_UF) FROM SENSO;

--COUNT POR ESTADO
SELECT A.ESTADO,COUNT (*) 
    FROM SENSO A
    WHERE A.ANO='2014'
    GROUP BY A.ESTADO
    ORDER BY 2 DESC;
    
-- USANDO VARIAS FUNCOES DE AGREGAÇÃO
select avg(a.populacao) media_pop,
    min(a.populacao) minimo_pop,
    max(a.populacao) maximo_pop,
    sum(a.populacao) total_pop,
    count(*) qtd_cidades
    from senso a
    where a.ano=2014;

--por estado
select a.estado,
    avg(a.populacao) media_pop,
    min(a.populacao) minimo_pop,
    max(a.populacao) maximo_pop,
    sum(a.populacao) total_pop,
    count(*) qtd_cidades
    from senso a
    where a.ano=2014
    group by a.estado
    order by 2 desc;
    
-- apresentar nome da cidade com maior população de cada estado
select a.estado, a.nome_mun, a.populacao
    from (
        select b.estado, max(b.populacao) as populacao from senso b
            where b.ano=2014
            group by b.estado
    )b
    join senso a
        ON a.estado = b.estado 
            and a.populacao = b.populacao
    where a.ano=2014
    order by a.populacao desc;
    
-- apresentar nome da cidade com menor população de cada estado
select a.estado, a.nome_mun, a.populacao
    from (
        select b.estado, min(b.populacao) as populacao from senso b
            where b.ano=2014
            group by b.estado
    )b
    join senso a
        ON a.estado = b.estado 
            and a.populacao = b.populacao
    where a.ano=2014
    order by a.populacao desc;
    
--STDDEV retorna o desvio padrão estatistico de todos os valores da expressao especificada
select STDDEV(a.populacao) from senso a
    where a.ano=2014;
    
-- comparando crescimento populacional da cidade com ano de referencia de 2010 a 2014
--select cod_uf, cod_mun, cod_uf+cod_mun as concatenado from cidades;
-- exemplo
select * from senso;
select a.estado,
    a.nome_mun,
    a.populacao as senso_2010,
    a.populacao as senso_2014,
    (100/a.populacao)*(b.populacao)-100 as percentual
    from senso a
    inner join senso b 
        ON a.cod_mun=b.cod_mun
        where a.ano=2010 
            and b.ano=2014
    order by 5;
    
--coparando crescimento por estado
select a.estado, 
    sum(a.populacao) as senso_2010,
    sum(b.populacao) as senso_2014,
    (100/sum(a.populacao))*(sum(b.populacao))-100 as percentual
    from senso a
    inner join senso b
        ON a.cod_mun = b.cod_mun
    where a.ano='2010' and b.ano='2014'
    group by a.estado
    order by 4 desc;
    
-- var pop com group by
select estado, var_pop(populacao) from senso
    group by estado;
    
-- VAR_SAMP retorna a variancia estatistica para o preenchimento
-- de todos os valores da expressao especificada
select var_samp(populacao) from senso;

-- var_samp com group BY
select estado, var_samp(populacao) from senso
    group by estado;
    