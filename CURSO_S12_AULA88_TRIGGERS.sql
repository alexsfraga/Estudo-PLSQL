-- TRIGGERS 

--drop table EMPREGADOS;
--drop table log_salario;
--drop trigger trg_salario_aud

CREATE TABLE EMPREGADOS
  (
    CODIGO INT NOT NULL PRIMARY KEY,
    NOME VARCHAR2(20),
    SALARIO DECIMAL(10,2)
    );
    
CREATE TABLE log_salario 
    (
    codigo INT,
    salario_anterior DECIMAL(10,2),
    salario_atual  DECIMAL(10,2),
    data_alteracao DATE,
    usuario VARCHAR2(20),
    operacao varchar2(10)
    );
    

--exemplo each row
CREATE OR REPLACE TRIGGER trg_salario_aud
after INSERT or update ON EMPREGADOS
FOR EACH ROW
BEGIN
INSERT INTO log_salario 
                   (codigo,salario_anterior,salario_atual,data_alteracao,usuario,operacao) 
      VALUES      (:NEW.codigo,:OLD.SALARIO,:NEW.SALARIO,SYSDATE,USER,'');
END;

--Teste insert
INSERT INTO EMPREGADOS VALUES (1,'Peter',2999);
INSERT INTO EMPREGADOS VALUES (2,'john',3499);
update empregados set salario=4299 where codigo=1;
select * from EMPREGADOS;

select * from log_salario;

--teste update

update EMPREGADOS set salario=salario*1.10
where CODIGO='1';

--desabilitando trigger
alter trigger trg_salario_aud disable;

--apos disable
INSERT INTO EMPREGADOS VALUES (3,'Mary',4499);
--habilitando trigger
alter trigger trg_salario_aud enable;

-- Exemplo com operadores  
--Exemplo statements/declaracao de operadores
CREATE OR replace TRIGGER trg_salario_aud 
  AFTER INSERT OR DELETE OR UPDATE ON empregados 
  FOR EACH ROW
  DECLARE
    p_oper VARCHAR2(10);
BEGIN 
    IF inserting THEN 
      p_oper:='insere';
      INSERT INTO log_salario 
                  (codigo,salario_anterior,salario_atual,data_alteracao,usuario,operacao) 
      VALUES      (:NEW.codigo,NULL,:NEW.SALARIO,SYSDATE,USER,P_oper);
      
    ELSIF updating THEN 
       p_oper:='atualiza';
      INSERT INTO log_salario 
                   (codigo,salario_anterior,salario_atual,data_alteracao,usuario,operacao) 
      VALUES      (:NEW.codigo,:OLD.SALARIO,:NEW.SALARIO,SYSDATE,USER,P_oper); 
    ELSIF deleting THEN 
      p_oper:='deleta';
       INSERT INTO log_salario 
                  (codigo,salario_anterior,salario_atual,data_alteracao,usuario,operacao) 
      VALUES      (:old.codigo,:OLD.SALARIO,NULL,SYSDATE,USER,p_oper); 
    END IF; 
END; 
/ 

--testando 

INSERT INTO EMPREGADOS VALUES (5,'Lennon',3499);
update empregados set salario=salario*1.05 where codigo='1';
delete from EMPREGADOS where codigo='3'

select * from log_salario;


drop TRIGGER trg_restricao_emp;
-- exemplo de trigger de restri��o de horario
CREATE OR REPLACE TRIGGER trg_restricao_emp
    BEFORE INSERT OR DELETE OR UPDATE
        ON empregados
        REFERENCING NEW AS NEW OLD AS OLD
BEGIN
    IF TO_NUMBER (TO_CHAR (SYSDATE, 'hh24')) NOT BETWEEN 9 AND 18
    THEN
        --raise_application_error(-20001,"Opera��o n�o pode ser executada fora do hor�rio de expediente.");
        raise_application_error(-20001,'Opera��o n�o pode ser executada fora do hor�rio de expediente.');

    END IF;
END;
/
declare
    --v_d varchar := select to_char(sysdate,'ddmmyyyyhh24miss') from dual;
    v_t NUMBER := TO_NUMBER ( TO_CHAR (SYSDATE,'hh24') );
begin
    DBMS_OUTPUT.PUT_LINE(v_t);
end;

alter trigger trg_restricao_emp disable;
alter trigger trg_restricao_emp enable;

select * from EMPREGADOS;
select * from log_salario;