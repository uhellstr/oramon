CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_EXEC_PARSE_TIME" 
 ( "SNAP_TIME", "EXECUTION_TIME", "PARSE_TIME", "RELOAD"
  )  AS 
  select snap_time
      ,to_char(CPU_used_by_this_session,'9999999999999990.99') execution_time
      ,to_char(parse_time_cpu,'9999999999999990.99') parse_time
      ,to_char(case when (parse_time_elapsed - parse_time_cpu) < 0 then 0 else (parse_time_elapsed - parse_time_cpu) end,'9999999999999990.99') reload
from
(
select to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time ,sys.name
, ROUND((sys.value - (lag( sys.value ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time,sys.name order by snap.snap_id )))/100
/((snap.snap_time - (lag( snap.snap_time ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time,sys.name order by snap.snap_id ))) * 24 * 60 * 60) *60,2) diff_value
from stats$sysstat sys,stats$snapshot snap
where sys.snap_id= snap.snap_id
and sys.dbid   = snap.dbid
and sys.instance_number = snap.instance_number
and sys.name in ('parse time elapsed','parse time cpu','CPU used by this session')
and snap.snap_time between trunc(sysdate-30) and sysdate
)
pivot (max(diff_value) for name in ('parse time elapsed'             parse_time_elapsed
                                    ,'parse time cpu'      parse_time_cpu
                                    ,'CPU used by this session'  CPU_used_by_this_session
                                   )
)
order by snap_time