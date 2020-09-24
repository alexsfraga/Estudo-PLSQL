--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- Funções de cadeia de caracteres para descobrir o codigo ascii de um caracter
--exemplo com ASCII
select ascii('ab')teste from sys.dual
    union all
select ascii('a') from sys.dual
    union all
select ascii('b') from sys.dual;

-- exemplo com LOWER(), usado para retornar tudo em minusculo ou caixa baixa
select a.department_name nome_depto,
    LOWER(a.department_name) nome_1ower,
    LOWER('Curso SQL')
    from hr.departments a;
    
--exemplo com UPPER(), usado para retornar tudo em caixa alta ou maiusculo
select a.department_name nome_depto,
    UPPER(a.department_name) nome_upper,
    UPPER('Curso SQL')
    from hr.departments a;
    
--exemplo com initcap(), retorna somente a primeira letra em caixa alta
select a.department_name nome_depto,
    INITCAP(UPPER(a.department_name)) nome_initcap,
    INITCAP('Curso SQL')
    from hr.departments a;
    
-- exemplo concat para concatenar valores, não permite concatenar tipo de dado diferente
select a.first_name,
    a.last_name,
    concat(a.first_name,concat(' ',a.last_name)) concatenado
    from hr.employees a;
    
-- outra opção ou forma de CONCATENAR, permite concatenar tipo de dados diferente
select a.first_name,
    a.last_name,
    a.first_name||' '||a.last_name as nome_completo,
    a.first_name||' '||a.salary as nome_salario
    from hr.employees a;
    
--exemplo de LPAD() completa com dados a esquerda
select a.employee_id,
    LPAD(a.employee_id,10,'0')id_pad,
    a.first_name
    from hr.employees a;
    
-- exemplo RPAD() completa com dados a direita
select a.employee_id,
    RPAD(a.employee_id,10,'0')id_pad,
    a.first_name
    from hr.employees a;
    
-- exemplo substring() traz parte da expresao desejada
select substr('orange',2,4) from sys.dual;

select a.first_name,
    a.last_name,
    substr(a.last_name,1,1),
    concat(substr(a.first_name,1,1),substr(a.last_name,1,1))texto3
    from hr.employees a;

select a.first_name,
    substr(a.first_name,1,3)parte1,
    substr(a.first_name,4,10)parte2
    from hr.employees a;
    
--exemplo com instr()
select a.job_title, instr(a.job_title,'r') posicao from hr.jobs a;
select a.job_title, instr(a.job_title,'es') posicao from hr.jobs a;
select a.job_title, instr(a.job_title,'re') posicao from hr.jobs a;
--exemplo buscando T a partir da posição 10
select a.job_title, instr(a.job_title,'t',10) posicao from hr.jobs a;

--exemplo LTRIM(), ira limpar os espaços existentes a esquerda
select a.job_title, LTRIM(a.job_title,'A') posicao from hr.jobs a;
--exemplo LTRIM(), ira limpar os qualquer ocorrencia de um dos caracteres em uma sequencia de caracteres
select a.job_title, LTRIM(a.job_title,'AFPS') posicao from hr.jobs a;

-- exemplo LTRIM removendo espaços no texto
select '      Andre' com_espaco,
    LTRIM('             Andre',' ')sem_espaco
    from dual;
    
--exemplo RTRIM()
select a.job_title, RTRIM(a.job_title,'tre') posicao from hr.jobs a;

--exemplo com LENGTH(), conta quantos caracteres possui determinado texto ou campo
select a.job_title,
    LENGTH(a.job_title)tamanho
    from hr.jobs a;
    
--exemplo com TRANSLATE(), utilizado para substituir caracter um pelo outro
select a.job_title,
    TRANSLATE(a.job_title,'S','X') traducao
    from hr.jobs a;
    
-- exemplo com REPLACE()
select a.job_title, 
    REPLACE(a.job_title,'Manager','Gerente') traducao
    from hr.jobs a;
    
-- exemplo DECODE()
select a.job_title from hr.jobs a;

select a.job_title,
        decode(job_title,
                'President','Presidente',
                'Administration Vice President','Vice Presidente ADM')
        from hr.jobs a;
        
--exemplo REVERSE(), inverte a cadeia de caracteres desejada
select a.job_title,
    reverse(a.job_title)revertido
    from hr.jobs a;

--outras funcoes
-- DUMP() traz o tipo, o tamanho, e a posição da tabela ascii de cada caracter em sequencia 
-- e o VSIZE()traz o tamanho do texto e ou campo
select (a.first_name)nome,
        DUMP(a.first_name)dump_nome,
        VSIZE(a.first_name)size_nome
        from hr.employees a;
