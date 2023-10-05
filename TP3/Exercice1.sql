-- Exercice 1 -- 

set linesize 75;
-- 1.1.1.1 -- 
/*
Select distinct TABLESPACE_name, table_name, Num_rows from USER_TABLES;

Select distinct TABLESPACE_name, table_name, num_rows from dba_tables;
*/
-- 1.1.1.2 -- 
/*
show parameter 
show parameter db_block_size 

select name, value from v$parameter where name like 'db_block%';
*/

-- 1.1.1.3 --
/*
ANALYZE TABLE EMP COMPUTE STATISTICS

--Seeing the amount of allocated blocks -- 
SELECT TABLE_NAME,
       BLOCKS + EMPTY_BLOCKS AS TOTAL_BLOCKS,
       (BLOCKS + EMPTY_BLOCKS) * (SELECT VALUE FROM V$PARAMETER WHERE NAME = 'db_block_size') AS TOTAL_BYTES
FROM USER_TABLES
WHERE TABLE_NAME = 'EMP';
*/

-- 1.2 -- 

CREATE TABLE test (
  num NUMBER(3) CONSTRAINT num_domain_check CHECK (num >= 0 AND num <= 999),
  commentaire CHAR(97)
);




