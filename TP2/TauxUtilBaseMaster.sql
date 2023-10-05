-- Script Exercice 3.2.1 -- 

set serveroutput on 

CREATE OR REPLACE PACKAGE Supervision AS
    -- Déclaration de la fonction pour le taux d'utilisation de la base
    FUNCTION CalculateUtilizationRate RETURN NUMBER;
END Supervision;
/


CREATE OR REPLACE PACKAGE BODY Supervision AS
    -- Implémentation de la fonction
    FUNCTION CalculateUtilizationRate RETURN NUMBER IS
        total_sessions NUMBER;
        referenced_users NUMBER;
        utilization_rate NUMBER;
    BEGIN
        -- Comptez le nombre total de sessions actives
        SELECT COUNT(*) INTO total_sessions FROM v$session;

        -- Comptez le nombre d'utilisateurs référencés dans dba_users
        SELECT COUNT(*) INTO referenced_users FROM dba_users;

        
        IF referenced_users = 0 THEN
            utilization_rate := 0;
        ELSE
            utilization_rate := (total_sessions / referenced_users) * 100;
        END IF;

        RETURN utilization_rate;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL; 
    END CalculateUtilizationRate;
END Supervision;
/

-- Test : --  

DECLARE
    utilization_rate NUMBER;
BEGIN
    utilization_rate := Supervision.CalculateUtilizationRate;
    DBMS_OUTPUT.PUT_LINE('Taux d''utilisation de la base : ' || utilization_rate);
END;
/