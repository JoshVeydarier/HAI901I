-- Script Exercice 3.2.4 -- 


SET SERVEROUTPUT ON;

-- Créez la procédure
CREATE OR REPLACE PROCEDURE ShowUserPrivileges(
    p_username VARCHAR2
) AS
BEGIN
    -- Affichez les rôles de l'utilisateur
    FOR role_rec IN (SELECT GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE = p_username) LOOP
        DBMS_OUTPUT.PUT_LINE('Role : ' || role_rec.GRANTED_ROLE);
    END LOOP;

    -- Affichez les privilèges de l'utilisateur
    FOR privilege_rec IN (SELECT PRIVILEGE FROM DBA_SYS_PRIVS WHERE GRANTEE = p_username) LOOP
        DBMS_OUTPUT.PUT_LINE('Privilege : ' || privilege_rec.PRIVILEGE);
    END LOOP;
END;
/

BEGIN
    ShowUserPrivileges('E20190008435');
END;
/