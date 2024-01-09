create or replace view oramon_exec_per_seconds as
select  snap_id
       ,snap_time
       ,diff_value
       ,to_char(round(diff_value/diff_sec,2),'9999999999999990.99') exec_per_sec
       ,host_name
       ,(select get_instance_name from dual) as instance_name
from
(
select snap_id
       ,snap_time
       ,diff_value
       ,diff_sec
       ,host_name
from
(
select snap.snap_id
       , to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
       , sys.value - (lag( sys.value ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_value
       , (snap.snap_time - (lag( snap.snap_time ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id ))) * 24 * 60 * 60 diff_sec
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
) where diff_value is not null
  or diff_sec is not null
)
order by snap_id;