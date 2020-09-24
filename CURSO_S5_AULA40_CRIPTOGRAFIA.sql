--curso  https://www.udemy.com/course/oracle-developer-sql-e-plsql/
--CRIPTOGRAFIA
-- RAWTOHEX
-- DBMS_OBFUSCATION_TOOLKIT
-- UTL_RAW

SET SERVEROUT ON

DECLARE 
    v_str VARCHAR2(100);
    v_frase VARCHAR2(100);
    BEGIN
    --ATRIBUIR VALOR
    v_frase :='Utilidades Oracle';
    
    --GENERATE ENCODED VALUE
    --PARAM 1 BUF VALUE
    --PARAM 2 ENCODE_CHARSET SAO TIPO WE8ISO8859P1 - AL32UTF8
    --PARAM 3 ENCODING - BASE64
    v_str := utl_encode.text_encode(v_frase ,'WE8ISO8859P1',UTL_ENCODE.BASE64);
    --IMPRIMIR VALOR
    dbms_output.put_line(v_str);
    
    --take the encoded value and decod it
    v_str := utl_encode.text_encode(v_str,'WE8ISO8859P1',UTL_ENCODE.BASE64);
    
    --IMPRIMIR VALOR
    dbms_output.put_line(v_frase);
    dbms_output.put_line(v_str);
    
    END;


--exemplo 2 
   set serveroutput on
   
   DECLARE
   v_input varchar2(2000) := 'teste125';
   v_imput_cripto varchar2(32) := null;
   
   BEGIN
    v_imput_cripto := rawtohex(dbms_obfuscation_toolkit.md5(input => utl_raw.cast_to_raw(v_input)));
    dbms_output.put_line('O valor hash para "' || v_input || '" é "' || nvl(v_imput_cripto, '')||'".');
   end;
   
--exemplo 3 criando uma funcao
drop function md5;
create or replace function md5 ( valor varchar)
    return varchar2 is
        v_imput varchar2(2000) := valor;
        v_imput_cripto varchar2(32) := null;
        begin
            v_imput_cripto:= rawtohex(dbms_obfuscation_toolkit.md5(input => utl_raw.cast_to_raw(v_imput)));
            return nvl(v_imput_cripto,'');
        END;
--testando funcao
select md5('minha senha') from dual;

 --testando função com select comparando valores
select 'TRUE' as retorno from dual
    where '59338FBB2123B37E0F25E3E82E132335' = md5('minhasenha_errada'); 

 --testando função com select comparando valores
    select 'TRUE' as retorno from dual
   where '59338FBB2123B37E0F25E3E82E132335' = md5('minha senha');
   
    --testando função com select comparando valores
    select 'TRUE' as retorno from dual
   where '59338FBB2123B37E0F25E3E82E132335' ='minhasenha';