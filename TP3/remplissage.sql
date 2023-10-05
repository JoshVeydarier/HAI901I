create or replace procedure remplissage (borneInf in number, borneSup in number) is
i number;
comme char(97);
begin
comme := 'cot_';
for i in borneInf .. borneSup
loop
comme := dbms_random.value || i ;
insert into test values (i,comme);
end loop;
commit;
exception
when others then dbms_output.put_line(SQLCODE||'  '||SQLERRM);
end;
/

exec remplissage(1,200)