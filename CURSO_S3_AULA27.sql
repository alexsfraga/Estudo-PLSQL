--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
--REVOGANDO PREVILEGIOS 
REVOKE CREATE VIEW,CREATE PROCEDURE, CREATE SESSION, CREATE TABLE FROM ALUNO;

-- 
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE SESSION, CREATE TABLE TO ALUNO;


--ANALISANDO
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE LIKE 'ALUNO';

REVOKE RESOURCE FROM ALUNO;
GRANT RESOURCE TO ALUNO;

REVOKE UPDATE ON HELP FROM ALUNO;
GRANT UPDATE ON HELP TO ALUNO;