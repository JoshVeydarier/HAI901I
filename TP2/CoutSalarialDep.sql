-- Script Exercice 3.1.2 -- 


CREATE OR REPLACE FUNCTION GetTotalSalaryCost(p_deptno NUMBER) RETURN NUMBER IS
    total_salary NUMBER := 0;
BEGIN
   
    SELECT SUM(SALAIRE) INTO total_salary FROM EMP WHERE N_DEPT = p_deptno;

    RETURN total_salary;
END GetTotalSalaryCost;
/

-- To test : -- 

DECLARE
    dept_no NUMBER := 20; 
    total_cost NUMBER;
BEGIN
    total_cost := GetTotalSalaryCost(dept_no);
    DBMS_OUTPUT.PUT_LINE('Cout salarial total pour le departement ' || dept_no || ': ' || total_cost);
END;
/