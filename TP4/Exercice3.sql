-- Exercice 3 -- 

set serveroutput on;

set linesize 3000

-- Exercice 3.1.1 -- 

select bytes / 1024 / 1024  from v$sgainfo where name = 'Shared Pool Size' ;

-- Exercice 3.1.2 -- 

select bytes / 1024 / 1024  from v$sgainfo where name = 'Buffer Cache Size' ;

-- Exercice 3.1.3 -- 

select bytes / 1024 / 1024 from v$sgainfo where name = 'Redo Buffers' ;

-- Exercice 3.1.4 -- 


 select sum(bytes) / 1024 / 1024 / 1024 from v$sgainfo where name = 'Maximum SGA Size';
 

 -- Exercice 3.2.2 --

Create or replace procedure User_Activity(p_schema_name VARCHAR2) AS
BEGIN
for r in (Select sql_id, sql_text, disk_reads, parsing_schema_name, cpu_time, elapsed_time, executions, buffer_gets
from v$sqlarea where parsing_schema_name = p_schema_name ORDER BY last_load_time DESC )
LOOP

dbms_output.put_line('SQL ID:' || r.sql_id);
dbms_output.put_line('SQL TEXT:' || r.sql_text);
dbms_output.put_line('DISK READS:' || r.disk_reads);
dbms_output.put_line('CPU TIME:' || r.cpu_time);
dbms_output.put_line('ELAPSED TIME:' || r.elapsed_time);
dbms_output.put_line('EXECUTIONS:' || r.executions);
dbms_output.put_line('-----------------------------');

END LOOP;
END;
/

Create or replace procedure Costly_Cursors AS 
BEGIN
for r in (Select sql_id, sql_text, disk_reads, parsing_schema_name, cpu_time, elapsed_time, executions, buffer_gets
from v$sqlarea ORDER BY disk_reads DESC fetch first 10 rows only )
LOOP

dbms_output.put_line('SQL ID:' || r.sql_id);
dbms_output.put_line('SQL TEXT:' || r.sql_text);
dbms_output.put_line('DISK READS:' || r.disk_reads);
dbms_output.put_line('CPU TIME:' || r.cpu_time);
dbms_output.put_line('ELAPSED TIME:' || r.elapsed_time);
dbms_output.put_line('EXECUTIONS:' || r.executions);
dbms_output.put_line('-------------PEEN----------------');

END LOOP;
END;
/


exec User_Activity('E20150007033');

exec Costly_Cursors;

/*
-- Exercice 3.3.1 -- 

Select 1- (phy.value / ( cons.value + db.value - phy.value))
from v$sysstat phy, v$sysstat cons, v$sysstat db
where phy.name =' physical reads' and cons.name ='consistent gets' and db.name ='db block
gets';


-- Exercice 3.3.2 -- 

select file#, block#, class#, dirty, objd, object_name, owner
from v$bh, dba_objects where dirty = 'Y' and objd = object_id;



-- Exercice 3.4 -- 

select p.pid, bg.name, bg.description, p.program
from v$bgprocess bg, v$process p
where bg.paddr = p.addr order by p.pid;

-- Exercice 3.5 -- 

-- Exercice 3.5.1 --

select tablespace_name from dba_tablespaces; 

-- Exercice 3.5.2 --

select FILE#, status, block_size from v$datafile; 

-- Exercice 3.5.3 --

select GROUP#, member from v$logfile;

-- Exercice 3.5.4 --

select status, name, block_size from v$controlfile;

-- Exercice 3.5.5 -- 

select tablespace_name, count(*) as numberfiles from dba_data_files
group by tablespace_name;

*/