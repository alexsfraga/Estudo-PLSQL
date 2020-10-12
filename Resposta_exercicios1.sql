-- escreva a tabuada em pl/sql a seguir:
-- 5 x 1 = 5
-- 5 x 2 = 10
-- RESPOSTA :
declare
    v_var1 constant number(2) := 5;
    begin
        FOR I IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE(v_var1 || ' X ' || I || ' = ' || v_var1*I);
        END Loop;
    End;
    
-- imprimir a tabuada
-- 1 * 1 = 1
-- 1 * 2 = 2
-- ....
-- 10 * 9 = 90
-- 10 * 10 = 100

begin 
    for x in 1..10 loop
        
        for y in 1..10 loop
            dbms_output.put_line(x || ' x ' || y || ' = ' || x*y);
        end loop;

    end loop;
end;


-- criar bloco pl\sql para imprimir anos Bissextos entre 2000 e 2100,
-- um ano sera Bissexto quando dividi-lo por 4, mas não for possivel dividi-lo por 400
    
declare
    v_inicio number := &v1;
    v_fim number := &v2;
    v_divisor number;
    v_mod4 number;
    v_mod100 number;
    v_mod400 number;
    begin
        if v_fim >= v_inicio then
            --v_inicio := v_inicio-1;
            --v_divisor
            for v_divisor in v_inicio .. v_fim loop
                --DBMS_output.put_line('variavel= '||v_divisor);
                v_mod4 := mod(v_divisor,4);
                v_mod100 := mod(v_divisor,100);
                v_mod400 := mod(v_divisor,400);
                if( (v_mod4 =0 AND v_mod100 =0 AND v_mod400 =0) OR (v_mod4 =0 AND v_mod100 !=0) ) then
                    dbms_output.put_line(v_divisor || ' e um ano Bissexto');
                end if;
            end loop;
        else
            DBMS_output.put_line('Data final não pode ser inferior a data inicial !');
        end if;
    END;
    
-- criar tabela de produto e multiplicar seus valores para categoria A = 1.05, 
-- categiria B = 1.10, e para categoria C = 1.15
    
    create table produto_ex(
        codigo number(4),
        categoria char(1),
        valor number(4,2));
    insert into produto_ex values(1001,'A',7.55);
    insert into produto_ex values(1002,'B',5.95);
    insert into produto_ex values(1003,'C',3.45);
    
DECLARE
    --cursor c_prod is select p.codigo, p.categoria, p.valor from produto_ex p;
    cursor c_prod is select * from produto_ex;
    v_prod c_prod%ROWTYPE;
    
    BEGIN
        open c_prod;  
        LOOP
            fetch c_prod into v_prod;
            exit when c_prod%notfound;
                IF v_prod.categoria='A' THEN
                    DBMS_OUTPUT.PUT_LINE('Categoria = A -'||'codigo = '||v_prod.codigo );
                    update produto_ex set valor = valor*1.05 where codigo=v_prod.codigo;
                ELSIF v_prod.categoria='B' THEN
                    DBMS_OUTPUT.PUT_LINE('Categoria = B -'||'codigo = '||v_prod.codigo );
                    update produto_ex set valor = valor*1.10 where codigo=v_prod.codigo;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Categoria = C -'||'codigo = '||v_prod.codigo );
                    update produto_ex set valor = valor*1.15 where codigo=v_prod.codigo;
                END IF;
            --exit when c_prod%notfound;
            --update produto_ex set valor=c_prod*v_perc where codigo=c_prod.codigo;
        END LOOP;
        close c_prod;
    END;
select * from produto_ex;

begin 
    for v_prod in (select * from produto_ex) loop
        IF v_prod.categoria='A' THEN
                    DBMS_OUTPUT.PUT_LINE('Categoria = A -'||'codigo = '||v_prod.codigo );
        ELSIF v_prod.categoria='B' THEN
                    DBMS_OUTPUT.PUT_LINE('Categoria = B -'||'codigo = '||v_prod.codigo );
        ELSE
                    DBMS_OUTPUT.PUT_LINE('Categoria = C -'||'codigo = '||v_prod.codigo );
        END IF;
    end loop;
end;


-- imprimir a sequencia de fibonacci 1-1-2-3-5-8-13-34-55

declare
    v_pri number:=1;
    v_sec number:=0;
    v_ter number:=0;
begin
    for v_var in 1..55 loop
        if v_ter <= 55 then
            if v_pri =1 or v_sec = 1 then
                DBMS_OUTPUT.PUT_LINE(v_pri);
                v_ter := v_pri + v_sec;
                v_sec := v_pri;
                v_pri := v_ter;
            else
                DBMS_OUTPUT.PUT_LINE(v_pri);
                v_ter := v_pri + v_sec;
                v_sec := v_pri;
                v_pri := v_ter;
            end if;
        end if;
    end loop;
end;

select * from clientes;
alter table clientes add email varchar2(50);
select replace(c.fantasia,' ','') fantasia from clientes c;
update clientes set email=lower(replace(fantasia,' ',''))||'@clientes.vc';

create or replace procedure p_cliente_exercicio(p_cod_cli number) is
    v_cli clientes%ROWTYPE;
begin
    select * into v_cli from clientes where id_cliente = p_cod_cli;
    dbms_output.put_line(v_cli.fantasia||' - '||v_cli.email);
end;--fim procedure p_cliente_exercicio(p_cod_cli number)

drop procedure p_cliente_exercicio;
EXECUTE p_cliente_exercicio(2);
