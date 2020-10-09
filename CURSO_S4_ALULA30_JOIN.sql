--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
-- USANDO JOIN
drop table alunos;

CREATE TABLE alunos(
    ID_ALUNO INT NOT NULL,
    NOME VARCHAR(20) NOT NULL,
    PRIMARY KEY(ID_ALUNO)
);
CREATE TABLE disciplina (
    id_disciplina int not null,
    nome_disc varchar2(20),
    primary key (id_disciplina)
    );
CREATE TABLE matricula (
    id_aluno int not null,
    id_disciplina int not null,
    periodo varchar(10),
    primary key(id_aluno,id_disciplina),
    foreign key (id_aluno) references alunos(id_aluno),
    foreign key (id_disciplina) references disciplina(id_disciplina)
);

insert into alunos(id_aluno, nome) values(1,'joão');
insert into alunos(id_aluno, nome) values(2,'maria');
insert into alunos(id_aluno, nome) values(3,'pedro');
insert into alunos(id_aluno, nome) values(4,'tiago');
insert into alunos(id_aluno, nome) values(5,'henrique');
select * from alunos;

insert into disciplina(id_disciplina,nome_disc) values(1,'fisica');
insert into disciplina(id_disciplina,nome_disc) values(2,'quimica');
insert into disciplina(id_disciplina,nome_disc) values(3,'matematica');
insert into disciplina(id_disciplina,nome_disc) values(4,'banco de dados');
insert into disciplina(id_disciplina,nome_disc) values(5,'programacao');
select * from disciplina;

insert into matricula values(1,1,'noturno');
insert into matricula values(1,2,'vespertino');
insert into matricula values(1,3,'matutino');
insert into matricula values(2,3,'noturno');
insert into matricula values(2,4,'noturno');
insert into matricula values(3,1,'noturno');
insert into matricula values(3,3,'noturno');
insert into matricula values(3,4,'noturno');
insert into matricula values(5,1,'matutino');
insert into matricula values(5,2,'vespertino');
insert into matricula values(5,4,'noturno');
select * from matricula;

select a.nome, c.nome_disc,b.periodo 
    from alunos a
    inner join matricula b ON a.id_aluno=b.id_aluno
    inner join disciplina c ON b.id_disciplina=c.id_disciplina;
    
select a.nome, c.nome_disc, b.periodo
    from alunos a
    left join matricula b
        ON a.id_aluno=b.id_aluno
    left join disciplina c
        ON b.id_disciplina= c.id_disciplina;
        

select a.nome, c.nome_disc, b.periodo
    from alunos a
    right join matricula b
        ON a.id_aluno=b.id_aluno
    right join disciplina c
        ON b.id_disciplina= c.id_disciplina;
        
select a.nome, c.nome_disc, b.periodo
    from alunos a
    full join matricula b
        ON a.id_aluno=b.id_aluno
    full join disciplina c
        ON b.id_disciplina= c.id_disciplina;
        
select * from HR.employees;
select * from HR.departments;
select * from HR.jobs;

select a.employee_id, a.first_name, b.department_name, c.job_title
    from hr.employees a
    inner join hr.departments b
        ON a.department_id=b.department_id
    inner join HR.jobs c
        ON a.job_id=c.job_id
        order by 1;

select a.employee_id, a.first_name, b.department_name, c.job_title
    from hr.employees a
    right join hr.departments b
        ON a.department_id=b.department_id
    right join HR.jobs c
        ON a.job_id=c.job_id
        order by 1 ;

select a.employee_id, a.first_name, b.department_name, c.job_title
    from hr.employees a
    inner join hr.departments b
        ON a.department_id=b.department_id
    inner join HR.jobs c
        ON a.job_id=c.job_id
        where a.first_name is null
            or b.department_name is null 
            or c.job_title is null ;
    
    
    
    
    