-- escreva a tabuada em pl/sql a seguir:
-- 5 x 1 = 5
-- 5 x 2 = 10
-- RESPOSTA :
declare
    v_var1 constant number(2) := 5;
    begin
        FOR I IN 1..2 LOOP
            DBMS_OUTPUT.PUT_LINE(v_var1 || ' X ' || I || ' = ' || v_var1*I);
        END Loop;
    End;
    
declare
    v_var1 constant number(2) := 1;
    v_var2 constant number(2) := 10;
    V_VAR3 NUMBER(2) := 9;
    begin
        FOR I IN 1..2 LOOP
            DBMS_OUTPUT.PUT_LINE(v_var1 || ' X ' || I || ' = ' || v_var1*I);
        END Loop;
        FOR I IN 1..2 LOOP
            DBMS_OUTPUT.PUT_LINE(v_var2 || ' X ' || I || ' = ' || v_var2*V_VAR3);
            IF I = 1 THEN
                V_VAR3 := 10;
            END IF;
        END Loop;
    End;
    
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