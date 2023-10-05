-- Exercice 3.1.1 -- 

Set serveroutput on 


CREATE OR REPLACE PROCEDURE GetEmployeesByDept(
    p_deptno NUMBER,
    p_result OUT VARCHAR2
) AS
BEGIN
    p_result := NULL; 


    FOR emp_rec IN (SELECT NOM FROM EMP WHERE N_DEPT = p_deptno) LOOP
        IF p_result IS NULL THEN
            p_result := emp_rec.NOM;
        ELSE
            p_result := p_result || ', ' || emp_rec.NOM;
        END IF;
    END LOOP;
END;
/


-- To Test : --  

DECLARE
    dept_no NUMBER := 20; 
    employees_list VARCHAR2(4000); 
BEGIN
    GetEmployeesByDept(dept_no, employees_list);
    DBMS_OUTPUT.PUT_LINE('Employees in department ' || dept_no || ': ' || employees_list);
END;
/