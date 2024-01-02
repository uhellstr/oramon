CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_SGA" 
 ( "SNAP_ID", "SNAP_TIME", "COMPONENT", "MB", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select snap.snap_id
      ,to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
      ,mdc.component
      ,mdc.current_size/1024/1024 MB
      ,di.host_name
      ,(select get_instance_name from dual) as instance_name
from
stats$memory_dynamic_comps mdc
inner join stats$snapshot snap
on  mdc.snap_id= snap.snap_id
inner join perfstat.stats$database_instance di
on snap.dbid = di.dbid
where mdc.dbid   = snap.dbid
  and mdc.instance_number = snap.instance_number
  and snap.snap_time between trunc(sysdate-30) and sysdate
  and mdc.current_size > 0
  and mdc.component != 'SGA Target'
order by snap.snap_id