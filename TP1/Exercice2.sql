-- Trigger for exercice 2 -- 

set serveroutput on;
set linesize 300;

create or replace procedure JoursEtHeuresOuvrables
is
begin
if (to_char(sysdate,'DY')='SAT') or (to_char(sysdate,'DY')='SUN')
then
raise_application_error(-20010, 'Modification interdite le '||to_char(sysdate,'DAY') ) ;
end if;
end;
/


create or replace trigger Ouvrable
before delete or insert or update on EMP
begin
JoursEtHeuresOuvrables;
end ;
/