-- Trigger for exercice 1 -- 

set serveroutput on;
set linesize 300;

create or replace trigger rennesMille 
before insert or update on EMP
for each row
declare 
numDep Dept.n_dept%type;
begin
select n_dept into numDep from Dept where Lieu = 'Rennes';
if :new.salaire < 1000 
then raise_application_error(-21000, 'Error');
end if;
end;
/

