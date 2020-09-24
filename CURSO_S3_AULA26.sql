--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- PARTE 1 CONCEDER GRANT
-- CRIAR UM USUARIO E CONCEDER ACESSO NO BANCO E AOS OBJETOS
SELECT USER FROM DUAL;
--CONCEDENDO ACESSO DE ATUALIZA��O PARA USER ALUNO
GRANT UPDATE ON ALUNO.FUNCIONARIOS TO ALUNO;

--GRANT PARA O USUARIO TER PRIVILEGIO EM CONCEDER PRIVILEGIOS A OUTROS USUARIOS
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO ALUNO WITH ADMIN OPTION;

--CONCEDENDO ACESSO A UPDATE, SELECT
GRANT SELECT,UPDATE ON ALUNO.senso TO ALUNO;

--CONCEDENDO ACESSO DE INSERT, DELETE PARA ALUNO EM TABELA SENSO 
GRANT INSERT, DELETE ON ALUNO.senso TO ALUNO;

--CONCEDENDO DIREITO DE CRIAR VIEW E PROCEDURES
GRANT CREATE PROCEDURE, CREATE VIEW TO ALUNO;

--CONCEDENDO
SELECT 'GRANT ALL ON' || OBJECT_NAME || ' TO ALUNO;' AS RETORNO
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE='TABLE';
    
GRANT UPDATE ON HELP TO ALUNO;

GRANT INSERT (NOME,SETOR) ON ALUNO.funcionarios TO ALUNO;
GRANT UPDATE (NOME,SETOR) ON ALUNO.funcionarios TO ALUNO;

--CONCEDENDO ACESSO AO OBJETO PROCEDURE
GRANT EXECUTE ON ALUNO.PROC_QUADRADO TO ALUNO;

--CONCEDENDO ACESSO A TODOS OS OBJETOS 
GRANT ALL PRIVILEGES ON ALUNO.funcionarios TO ALUNO;

-- VERIFICANDO PREVILEGIOS 
SELECT * FROM DBA_SYS_PRIVS WHERE grantee LIKE 'ALUNO';
SELECT * FROM DBA_ROLE_PRIVS WHERE grantee LIKE 'ALUNO';
SELECT * FROM DBA_TAB_PRIVS WHERE grantee LIKE 'ALUNO';
SELECT * FROM USER_TAB_PRIVS;
SELECT * FROM USER_TAB_PRIVS WHERE TABLE_NAME='HR';
SELECT * FROM DBA_ROLE_PRIVS;

GRANT CREATE ANY VIEW TO ALUNO;