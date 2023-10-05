-- Script for exercice 3.2.3 -- 

-- Créez la procédure
CREATE OR REPLACE PROCEDURE ShowConnectedUsersInfo AS
BEGIN
    FOR user_rec IN (SELECT USERNAME, MACHINE, TERMINAL, LOGON_TIME FROM v$session WHERE TYPE = 'USER') LOOP
        -- Affichez les informations sur l'utilisateur
        DBMS_OUTPUT.PUT_LINE('Utilisateur : ' || user_rec.USERNAME);
        DBMS_OUTPUT.PUT_LINE('Machine : ' || user_rec.MACHINE);
        DBMS_OUTPUT.PUT_LINE('Terminal : ' || user_rec.TERMINAL);
        DBMS_OUTPUT.PUT_LINE('Heure de connexion : ' || TO_CHAR(user_rec.LOGON_TIME, 'DD-MON-YYYY HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;
END;
/

-- Test --
BEGIN
    ShowConnectedUsersInfo;
END;
/