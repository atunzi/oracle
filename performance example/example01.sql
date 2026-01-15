set lines 150 pages 100
col tracefile for a90


select s.sid,
       s.serial#,
       s.status,
       p.spid,
       p.tracefile
from   gv$session s,
       gv$process p
where  p.addr = s.paddr and p.inst_id = s.inst_id
  and  s.sid in (select sid from v$mystat where rownum <= 1);



show parameter optimizer
