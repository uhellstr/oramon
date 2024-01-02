CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_LOGONS" 
 ( "SNAP_ID", "SNAP_TIME", "VALUE", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select snap.snap_id
       ,to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
       ,sys.value
       ,di.host_name
       ,(select get_instance_name from dual) as instance_name
from stats$sysstat sys
inner join stats$snapshot snap
on sys.snap_id= snap.snap_id
inner join perfstat.stats$database_instance di
on snap.dbid = di.dbid
where  sys.name            = 'logons current'
  and sys.dbid   = snap.dbid
  and sys.instance_number = snap.instance_number
  and snap.snap_time between trunc(sysdate-30) and sysdate
order by snap_time