-- CURSOR PARTE 6

DECLARE
    -- Declaração de cursores
    CURSOR cs_func(pMenor NUMBER, pMaior NUMBER) is
            SELECT a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY
                    FROM HR.EMPLOYEES a
                    WHERE a.SALARY BETWEEN pMenor AND pMaior order by a.SALARY desc ;
BEGIN
    -- Abre cursor para Funcionarios com Salario entre 1000 e 9999
    dbms_output.put_line('Funcionarios com média entre 1000 e 9999');
    FOR rFunc in cs_func(1000,9999) LOOP
       /* Imprime na tela os Funcionarios com Salario no intervalo de 1000 e 9999
       */
      dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
    END LOOP;
    -- Abre cursor para Funcionarios com Salario entre 10000 e 19000
    dbms_output.put_line('Funcionarios com média entre 10000 e 19000');
    FOR rFunc in cs_func(10000,19000) LOOP
        /* Imprime na tela os Funcionarios com Salario entre 10000 e 19000
        Está no intervalo de 10000 e 19000
        */
        dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
    END LOOP;
END;


declare 
    v_menor number := &men;
    v_maior number := &mai;
    cursor c_func(pMenor number, pMaior number) is
            select a.employee_id, a.first_name, a.salary
                    from hr.employees a
                    where a.salary between pMenor AND pMaior
                    order by a.salary desc;
begin
    dbms_output.put_line('Funcionarios com média entre: '|| v_menor || ' e ' || v_maior);
    for rFunc in c_func(v_menor, v_maior) loop
        dbms_output.put_line(rFunc.employee_id || ' - ' || rFunc.first_name || ' - ' || rFunc.salary);
    end loop;
end;


-- PARTE 7

DECLARE
    -- Declaração de cursores
    CURSOR cs_func(pMenor NUMBER, pMaior NUMBER) is
            SELECT a.EMPLOYEE_ID,a.FIRST_NAME,a.SALARY
                    FROM HR.EMPLOYEES a
                    WHERE a.SALARY BETWEEN pMenor AND pMaior order by a.SALARY desc ;
BEGIN
    -- Abre cursor para Funcionarios com Salario entre 1000 e 9999
    dbms_output.put_line('Funcionarios com média entre 1000 e 9999');
    FOR rFunc in cs_func(10000,9999) LOOP
        /* Imprime na tela os Funcionarios com Salario no intervalo de 1000 e 9999
        */
        dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
    END LOOP;
        -- Abre cursor para Funcionarios com Salario entre 10000 e 19000
        dbms_output.put_line('Funcionarios com média entre 10000 e 19000');
    FOR rFunc in cs_func(10000,19000) LOOP
        /* Imprime na tela os Funcionarios com Salario entre 10000 e 19000
            Está no intervalo de 10000 e 19000
        */
        dbms_output.put_line(rFunc.EMPLOYEE_ID||' - '||rFunc.FIRST_NAME||' - '||rFunc.SALARY);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NÃO TEM REGISTROS');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;