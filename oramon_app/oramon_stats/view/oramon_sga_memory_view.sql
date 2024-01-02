CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_SGA_MEMORY" 
 ( "SNAP_ID", "SNAP_TIME", "NAME", "BVAL", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  with db as
(
select d.dbid            dbid
      , d.name            db_name
      , i.instance_number inst_num
      , i.instance_name   inst_name
   from v$database d,
        v$instance i
)
select b.snap_id
      ,snap.snap_time
      ,e.name
      , b.value                                            bval
      ,di.host_name
      ,(select get_instance_name from dual) as instance_name
from stats$sga b
inner join stats$sga e
on e.snap_id = b.snap_id
inner join perfstat.stats$database_instance di
on b.dbid = di.dbid
inner join db
on db.dbid = b.dbid
inner join stats$snapshot snap
on b.snap_id= snap.snap_id
where e.dbid            = db.dbid
  and e.instance_number = db.inst_num
  and b.dbid            = db.dbid
  and b.instance_number = db.inst_num
  and b.name            = e.name
  and snap.snap_time between trunc(sysdate-30) and sysdate
order by b.snap_id,e.name