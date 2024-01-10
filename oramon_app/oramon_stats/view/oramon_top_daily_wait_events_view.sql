CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_TOP_DAILY_WAIT_EVENTS" 
 ( "EVENT", "AGGR_EVENT", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select event
       ,sum(diff_value) aggr_event
       ,host_name
       ,instance_name
from
(
select
  snap_id
, snap_time
, event
, diff_value
, host_name
, instance_name
from
  oramon_wait_events
where to_date(snap_time,'RRRR-MM-DD HH24:MI:SS') between trunc(sysdate) and sysdate
) group by event,host_name,instance_name
order by aggr_event desc