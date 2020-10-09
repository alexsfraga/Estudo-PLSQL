--TIPOS DE REGISTROS
-- Exibe dados de um funcionario da tabela 'employees', schema 'hr' --
--% comercial na variavel fora PL/SQL pedir valor para variavel
set SERVEROUTPUT ON;

DECLARE
-- Definição de tipos
TYPE TFuncionario IS RECORD(
Nome VARCHAR2(40) ,
Depto VARCHAR2(20),
Salario NUMBER(10,2)
);
-- Declaração de variáveis
vFunc TFuncionario;
BEGIN
-- Atribuir valor para o registro vProduto
SELECT a.FIRST_NAME,a.DEPARTMENT_ID,a.SALARY
INTO vFunc.Nome, vFunc.Depto, vFunc.Salario
FROM hr.employees a
WHERE a.EMPLOYEE_ID = 103;
-- Imprimir na tela os dados recuperados
dbms_output.put_line('Nome do Func: '||vFunc.Nome||chr(10)||
'Depto: '||vFunc.Depto||chr(10)||
'Salario: '||to_char(vFunc.Salario)
);
END;
/



declare
    TYPE T_tbl is record(
        id_estado number,
        estado varchar2(20),
        uf varchar(5),
        cod_uf number,
        pib number
    );
    v_tbl T_tbl;
    begin
        select a.id_estado, a.estado, b.uf, a.cod_uf, a.pib
            into v_tbl.id_estado, v_tbl.estado, v_tbl.uf, v_tbl.cod_uf, v_tbl.pib
            from senso a inner join uf b
                ON a.id
                
                
                

    
select a.cod_uf, sum(a.populacao)
    from senso a
    where a.ano=2014
    group by a.cod_uf
    order by 2;
    
