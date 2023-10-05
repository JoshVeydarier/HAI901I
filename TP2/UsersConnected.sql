-- Script Exercice 3.2.2 -- 

CREATE OR REPLACE PROCEDURE ShowUserTableStats AS
BEGIN
    FOR user_rec IN (SELECT DISTINCT USERNAME FROM v$session WHERE USERNAME IS NOT NULL) LOOP
        -- Récupérez le nom d'utilisateur
        DBMS_OUTPUT.PUT_LINE('Utilisateur : ' || user_rec.USERNAME);

        -- Comptez le nombre de tables dans le schéma de l'utilisateur
        DECLARE
            table_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO table_count
            FROM dba_tables
            WHERE OWNER = user_rec.USERNAME;

            DBMS_OUTPUT.PUT_LINE('Nombre de tables : ' ||  table_count);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erreur lors du comptage des tables.');
        END;

        DECLARE
            tuple_count NUMBER := 0;
        BEGIN
            FOR table_rec IN (SELECT TABLE_NAME FROM dba_tables WHERE OWNER = user_rec.USERNAME) LOOP
                EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || user_rec.USERNAME || '.' ||  table_rec.TABLE_NAME INTO tuple_count;
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('Nombre total de tuples : ' || tuple_count);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erreur lors du comptage des tuples.');
        END;

        -- Comptez le nombre total de colonnes formant ces tables --
        DECLARE
            column_count NUMBER := 0;
        BEGIN
            FOR table_rec IN (SELECT TABLE_NAME FROM dba_tables WHERE OWNER = user_rec.USERNAME) LOOP
                SELECT COUNT(*) INTO column_count
                FROM dba_tab_columns
                WHERE OWNER = user_rec.USERNAME AND TABLE_NAME = table_rec.TABLE_NAME;
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('Nombre total de colonnes : ' || column_count);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erreur lors du comptage des colonnes.');
        END;

        
        DECLARE
            constraint_count NUMBER;
        BEGIN
            SELECT COUNT(*) INTO constraint_count
            FROM dba_constraints
            WHERE OWNER = user_rec.USERNAME AND CONSTRAINT_TYPE = 'R';

            DBMS_OUTPUT.PUT_LINE('Nombre de contraintes : ' || constraint_count);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erreur lors du comptage des contraintes.');
        END;

        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;
END;
/
-- Execute the procedure
BEGIN
    ShowUserTableStats;
END;
/