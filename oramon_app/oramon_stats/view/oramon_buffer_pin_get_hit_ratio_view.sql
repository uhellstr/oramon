CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_BUFFER_PIN_GET_HIT_RATIO" 
 ( "SNAP_ID", "SNAP_TIME", "PINHITRATE", "GETHITRATE", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select snap_id
       ,snap_time
       ,to_char(diff_pinhits/diff_pins,'0.999') pinhitrate
       ,to_char(diff_gethits/diff_gets,'0.999') gethitrate
       ,host_name
       ,(select get_instance_name from dual) as instance_name
from
(
select snap_id
      ,snap_time
      ,diff_pins
      ,diff_pinhits
      ,diff_gets
      ,diff_gethits
      ,host_name
from
(
select snap.snap_id
       , to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
       , lc.pinssum - (lag( lc.pinssum ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_pins
       , lc.pnhitssum - (lag( lc.pnhitssum ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_pinhits
       , lc.getsum - (lag( lc.getsum ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_gets
       , lc.gethitssum - (lag( lc.gethitssum ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time order by snap.snap_id )) diff_gethits
       , di.host_name
from
(
select snap_id
       ,snap_time
       ,dbid
       ,instance_number
       ,pinssum
       ,pnhitssum
       ,getsum
       ,gethitssum
from
(
select stl.snap_id
       ,pss.snap_time
       ,stl.dbid
       ,stl.instance_number
       ,sum(stl.pins) pinssum
       ,sum(stl.pinhits) pnhitssum
       ,sum(stl.gets) getsum
       ,sum(stl.gethits) gethitssum
from perfstat.stats$librarycache stl  
inner join perfstat.stats$snapshot pss
on    stl.snap_id= pss.snap_id
group by stl.snap_id,pss.snap_time,stl.dbid,stl.instance_number
order by snap_id
)) lc
inner join perfstat.stats$snapshot snap
on    lc.snap_id = snap.snap_id
inner join perfstat.stats$database_instance di
on lc.dbid = di.dbid
where lc.instance_number = di.instance_number
  and lc.snap_time between trunc(sysdate-30) and sysdate
)
order by snap_id
) where diff_pins > 0