--FUNÇÕES PARTE 1

drop FUNCTION Fn_mediaPond;
CREATE OR REPLACE FUNCTION Fn_mediaPond(
        nota1 in number,
        peso1 in number,
        nota2 in number,
        peso2 number
    )
    return number
        is
            media_pond number;
    begin
        media_pond := (nota1*peso1 + nota2*peso2)/(peso1 + peso2);
        return media_pond;
    end;
        
        
-- executando funcao

select Fn_mediaPond(5,5,10,1) from dual;
     
--CONCEDENDO ACESSO AO OBJETO PROCEDURE
GRANT EXECUTE ON ALUNO.fn_mediapond TO ALUNO;    
     
set serveroutput on;
begin
    dbms_output.put_line(
            Fn_mediaPond(5,5,10,1)
        );
end;
        
        
        
        
        --criando funçao para media ponderada;

CREATE OR REPLACE FUNCTION Fn_mediaPond
                    (nota1 in number,
                     peso1 in number,
                     nota2 in number,
                     peso2 in number)
return number
is
media_pond number;
begin
        media_pond:=(nota1*peso1+nota2*peso2)/(peso1+peso2);
        return media_pond;
end;
/

-- retornance valor de função
select  Fn_mediaPond(10,1,10,1) from SYS.DUAL;

-- REtornando atraves de output]
SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line(Fn_mediaPond(5,5,10,1)); 
END;
/
