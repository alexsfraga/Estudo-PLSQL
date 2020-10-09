-- PROCEDURES

--PARTE 1
-- PROCEDURES PODE OU PODE NÃO TER VALOR DE RETORNO
CREATE OR REPLACE
PROCEDURE PROC_DET_FUNC
IS
  CURSOR emp_cur
  IS
    SELECT first_name, last_name, salary FROM HR.EMPLOYEES;
    --RECEBENDO VALORES DO CURSOR
    emp_rec emp_cur%rowtype;
BEGIN
  FOR emp_rec IN emp_cur
  LOOP
    dbms_output.put_line('Nome do funcionario: ' || emp_rec.first_name);
    dbms_output.put_line('Sobrenome do funcionario: ' ||emp_rec.last_name);
    dbms_output.put_line('Salário do funcionario: ' ||emp_rec.salary);
    dbms_output.put_line('---------------------------------------------');
  END LOOP;
END;

--executando procedure
SET serveroutput on
begin
 PROC_DET_FUNC;
end;

--outra forma de execucao
EXECUTE PROC_DET_FUNC;


---- PARTE 2

-- criando uma procedure para retornar informações

CREATE OR REPLACE PROCEDURE PROC_INF_DEPTO
IS
  CURSOR FUN_CURSOR
  IS
    SELECT a.DEPARTMENT_ID,b.DEPARTMENT_NAME,SUM(salary)SALARIO FROM HR.EMPLOYEES a
    inner join HR.DEPARTMENTS b 
        on a.department_id=b.department_id
    group by a.DEPARTMENT_ID,b.DEPARTMENT_NAME;
    
    FUN_REC FUN_CURSOR%rowtype;
BEGIN
  FOR FUN_REC IN FUN_CURSOR
  LOOP
    dbms_output.put_line('Codigo Depto: ' || FUN_REC.DEPARTMENT_ID || 
     '. Nome Depto: ' ||FUN_REC.DEPARTMENT_NAME || '. Total Salário do Depto: ' ||FUN_REC.salario);
  END LOOP;
  exception
  when others then
  dbms_output.put_line('Erro: '||sqlerrm);
END;
/

--EXECUTANDO
EXECUTE PROC_INF_DEPTO;



------ PAETE 3

--PROCEDURE CALCULADORA
CREATE OR replace PROCEDURE proc_calc(
        operacao IN VARCHAR, --A ADICAO --D DIVISAO --S -SUBTR M --MULTIPL
        pnum1    IN NUMBER, 
        pnum2    IN NUMBER, 
        retorno OUT NUMBER)
     IS 
     MSG_OUTRAS EXCEPTION;
BEGIN 
 IF operacao='A' THEN 
    retorno := pnum1 + pnum2; 
  ELSIF operacao='S' THEN 
    retorno := pnum1 - pnum2; 
  ELSIF operacao='M' THEN 
    retorno := pnum1*pnum2; 
  ELSIF operacao='D' THEN 
    retorno := pnum1/pnum2; 
    else
    raise MSG_OUTRAS;
END IF; 
  EXCEPTION 
  WHEN MSG_OUTRAS THEN 
    dbms_output.put_line('Erro nao catalogado'); 
  WHEN OTHERS THEN 
    dbms_output.put_line('erro: '||SQLERRM); 
  END;
  /
  
  --EXECUTANDO PROCEDURE
  --A ADICAO --D DIVISAO --S -SUBTR M --MULTIPL
  SET SERVEROUTPUT ON;
  DECLARE
  retorno number:=0;
  v_op varchar(1):= 'X'; --&A_D_S_M
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Operação escolhida foi a opção = '|| v_op);
    proc_calc ( v_op , 10,3,retorno);
    dbms_output.put_line(retorno);
  END;
  /
  
  
--OUTRO EXEMPLO




---- PARTE 4


-- criando tabela para popular com procedure
--DROP TABLE EMPLOYEES_COPIA;
  CREATE TABLE EMPLOYEES_COPIA 
   (EMPLOYEE_ID NUMBER(6,0) PRIMARY KEY, 
	FIRST_NAME VARCHAR2(20 BYTE), 
	LAST_NAME VARCHAR2(25 BYTE), 
	EMAIL VARCHAR2(25 BYTE), 
	PHONE_NUMBER VARCHAR2(20 BYTE), 
	HIRE_DATE DATE, 
	JOB_ID VARCHAR2(10 BYTE), 
	SALARY NUMBER(8,2), 
	COMMISSION_PCT NUMBER(2,2), 
	MANAGER_ID NUMBER(6,0), 
	DEPARTMENT_ID NUMBER(4,0)
   );
   
-- VERIFICANDO TABELA CRIADA
SELECT * FROM EMPLOYEES_COPIA
 
-- criando procedure

CREATE OR REPLACE PROCEDURE PROC_COPIA_FUNC
    is
    BEGIN
        For func in (SELECT * FROM HR.EMPLOYEES)
            LOOP
                insert into EMPLOYEES_COPIA (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,
                                    MANAGER_ID,DEPARTMENT_ID) 
                                   values
                                   (func.EMPLOYEE_ID,func.FIRST_NAME,func.LAST_NAME,func.EMAIL,func.PHONE_NUMBER,
                                    func.HIRE_DATE,func.JOB_ID,func.SALARY,func.COMMISSION_PCT,func.MANAGER_ID,func.DEPARTMENT_ID);
            END LOOP;
            dbms_output.put_line('OK CARGA REALIZADA');
            COMMIT;
        exception
            when others then
                dbms_output.put_line('ERRO: '||sqlerrm);
            ROllBACK;
    end PROC_COPIA_FUNC;

-- EXECUTANDO PROCEDURE
EXECUTE PROC_COPIA_FUNC;

--Verificando dados;
   
-- VERIFICANDO TABELA CRIADA
SELECT * FROM EMPLOYEES_COPIA;
SELECT COUNT(*) FROM EMPLOYEES_COPIA;

-- EXECUTANDO PROCEDURE
EXECUTE PROC_COPIA_FUNC;

--DROP TABLE EMPLOYEES_COPIA
--DROP PROCEDURE PROC_COPIA_FUNC



--- PARTE 5
--DROP TABLE CAD_PESSOA;
CREATE TABLE CAD_PESSOA 
(
    ID_PESSOA INT NOT NULL PRIMARY KEY,
    NOME VARCHAR2(50),
    EMAIL VARCHAR(30),
    SITUACAO CHAR(1),
    CONSTRAINT CK_SITUA CHECK(SITUACAO IN('B','A'))
    );

--PROCEDURE DE CADASTRO
CREATE OR REPLACE PROCEDURE SP_CRUD (
                                  V_OPER       CHAR, --I INSERIR --A -ATUALIZA --S SELECIONA - D--DELETE
                                  V_ID_PESSOA  INTEGER,
                                  V_NOME       VARCHAR2,
                                  V_EMAIL      VARCHAR2,
                                  V_SITUACAO   CHAR)
IS
 --declarando variaveis
  V_SID_PESSOA INTEGER;
  V_SNOME VARCHAR2(50);
  V_SEMAIL VARCHAR2(30);
  V_SSITUACAO CHAR(1);
--declarando except
  v_EXCEPTION EXCEPTION;
  v_FALTA_CPO_INSERT EXCEPTION;
  v_FALTA_ID_DELETE EXCEPTION;
  v_FALTA_ID_UPDATE EXCEPTION;
BEGIN   
--verifica operacao de insert
  IF (V_OPER = 'I') THEN
    IF (V_ID_PESSOA is null or   V_ID_PESSOA='' or V_NOME is null OR V_NOME='' or  V_EMAIL is null or V_EMAIL='')
        then 
            ROLLBACK;
            RAISE v_FALTA_CPO_INSERT;
        else
        INSERT INTO CAD_PESSOA(ID_PESSOA, NOME,EMAIL, SITUACAO) VALUES (v_id_pessoa, v_NOME, v_email,'A');
    end if;
--verifica operacao de atualização
  ELSIF (V_OPER = 'A') THEN
     IF (V_ID_PESSOA is null or   V_ID_PESSOA='') 
     THEN
        ROLLBACK;
        RAISE v_FALTA_ID_UPDATE;
        ELSE
            UPDATE CAD_PESSOA SET NOME =NVL(V_NOME,NOME), EMAIL=NVL(V_EMAIL,EMAIL),SITUACAO=NVL(V_SITUACAO,SITUACAO)
           WHERE ID_PESSOA = V_ID_PESSOA;
      end if;  
  --verifica operacao de delete
  ELSIF(V_OPER = 'D')THEN
     IF (V_ID_PESSOA is null or V_ID_PESSOA='') 
       THEN
        ROLLBACK;
        RAISE v_FALTA_ID_DELETE;
        ELSE
            DELETE FROM CAD_PESSOA WHERE ID_PESSOA = V_ID_PESSOA;
     END IF;
 --verifica operacao de select
   ELSIF(V_OPER = 'S')THEN
    SELECT * INTO  V_SID_PESSOA,V_SNOME,V_SEMAIL,V_SSITUACAO 
    FROM CAD_PESSOA WHERE ID_PESSOA = V_ID_PESSOA;
    
     dbms_output.put_line('ID: '||V_SID_PESSOA); 
     dbms_output.put_line('Nome: '||V_SNOME); 
     dbms_output.put_line('e-mail: '||V_SEMAIL); 
     dbms_output.put_line('Situacao: '||V_SSITUACAO); 
    ELSE
    RAISE v_EXCEPTION;
  END IF;
    
 COMMIT;
    dbms_output.put_line('DADOS SELECIONADOS,INSERIDOS OU ATUALIZADO COM SUCESSO'); 
 --execpt   
  EXCEPTION
   
    WHEN v_EXCEPTION THEN 
      RAISE_APPLICATION_ERROR(-20999,'ATENÇÃO! Operação diferente de I, D, A OU S', FALSE);
    
    WHEN v_FALTA_CPO_INSERT THEN    
      dbms_output.put_line('FALHA NO INSERT, CAMPOS NAO PREENCHIDOS CORRETAMENTE!'); 
    
    WHEN v_FALTA_ID_UPDATE THEN  
      dbms_output.put_line('FALHA NO UPDATE, INFORME O ID!'); 
   
    WHEN v_FALTA_ID_DELETE THEN   
      dbms_output.put_line('FALHA NO DELETE, INFORME O ID!'); 
     
     WHEN OTHERS THEN
        IF SQLCODE='-00001' THEN
             DBMS_OUTPUT.PUT_LINE('ERRO: CODIGO JA EXISTE! ');
             DBMS_OUTPUT.PUT_LINE('ERRO: '||SQLERRM);
        ELSE
            DBMS_OUTPUT.PUT_LINE('CODIGO: '||SQLCODE);
            DBMS_OUTPUT.PUT_LINE('ERRO: '||SQLERRM);
            RAISE;
        END IF;
    ROLLBACK;
      
END ;
/
----I INSERIR --A -ATUALIZA --S SELECIONA - D--DELETE
--EXECUTANDO 
--REALIZANDO INSERT PARAM V_OPER,V_ID_PESSOA,V_NOME,V_EMAIL,V_SITUACAO

SET SERVEROUTPUT ON
DECLARE
    P_OPER CHAR(1);
    P_ID INT;
    P_NOME VARCHAR2(50);
    P_EMAIL VARCHAR2(30);
    P_SIT CHAR(1);
    BEGIN
      P_OPER:='S';
      P_ID:=2;
      P_NOME:='ROGERIO TESTE COM';
      P_EMAIL:='ROGERIOEMAIL';
      P_SIT:='A';
      
      SP_CRUD(P_OPER,P_ID,P_NOME,P_EMAIL,P_SIT);
    END;

SELECT * FROM CAD_PESSOA;
SELECT * FROM EMPLOYEES_COPIA
