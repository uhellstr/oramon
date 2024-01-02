CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_WAIT_EVENTS" 
 ( "SNAP_ID", "SNAP_TIME", "EVENT", "DIFF_VALUE", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select
  snap_id
  ,snap_time
  ,event
  ,round((value - pre_value) / 1000000, 2) diff_value
  ,host_name
  ,(select get_instance_name from dual) as instance_name
from
(
select snap.snap_id
       ,to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
       , event
       , event.time_waited_micro value
       , lag(event.time_waited_micro) over(partition by snap.dbid, snap.instance_number, event.event order by snap.snap_id) as pre_value
       ,di.host_name
from perfstat.stats$system_event event
inner join perfstat.stats$snapshot     snap
on event.snap_id = snap.snap_id
inner join perfstat.stats$database_instance di
on snap.dbid = di.dbid
where event.dbid = snap.dbid
  and event.instance_number = snap.instance_number
  and snap.snap_time between trunc(sysdate-30) and sysdate
  and not exists (
        select 1
        from v$event_name idle
        where idle.event_id = event.event_id
          and wait_class = 'Idle'
  )
  and not exists (
        select 1
        from stats$idle_event idle
        where idle.event = event.event
  )
union all
    select snap.snap_id
    , to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
    , 'CPU time'                                    event
    , sys.value / 100 * 1000000                     value
    , ( lag(sys.value) over(partition by snap.dbid, snap.instance_number, snap.startup_time order by snap.snap_id)) / 100 * 1000000 pre_value
    , di.host_name
    from perfstat.stats$sysstat  sys
    inner join perfstat.stats$snapshot snap
    on sys.snap_id = snap.snap_id
    inner join perfstat.stats$database_instance di
    on snap.dbid = di.dbid
    where  sys.name = 'CPU used by this session'
      and sys.dbid = snap.dbid
      and sys.instance_number = snap.instance_number
      and snap.snap_time between trunc(sysdate-30) and sysdate
)
where (( value - pre_value ) > 1000000
   or event = 'CPU time' )
  and pre_value is not null
order by snap_id, event