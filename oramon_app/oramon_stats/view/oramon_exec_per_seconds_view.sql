CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_EXEC_PER_SECONDS" 
 ( "SNAP_ID", "SNAP_TIME", "DIFF_VALUE", "EXEC_PER_SEC", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select  snap_id
       ,snap_time
       ,diff_value
       ,to_char(round(diff_value/diff_sec,2),'9999999999999990.99') exec_per_sec
       ,host_name
       ,(select get_instance_name from dual) as instance_name
from
(
select snap.snap_id
       , to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
       , sys.value - (lag( sys.value ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_value
       ,case (snap.snap_time - (lag( snap.snap_time ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id ))) * 24 * 60 * 60 
         when 0 then -1
        end diff_sec
       ,di.host_name
from stats$sysstat sys
inner join stats$snapshot snap
on sys.snap_id= snap.snap_id
inner join perfstat.stats$database_instance di
on snap.dbid = di.dbid
where sys.name            = 'execute count'
  and sys.dbid   = snap.dbid
  and sys.instance_number = snap.instance_number
  and snap.snap_time between trunc(sysdate-30) and sysdate
)
order by snap_id