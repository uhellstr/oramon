CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_CPUUSAGE" 
 ( "SNAP_ID", "SNAP_TIME", "LOAD", "PCT_BUSY", "PCT_USER", "PCT_SYS", "PCT_IOWT", "PCT_CPUWT", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select
  snap_id
, snap_time
, round(load) load
, round(100 * busy_time /(busy_time + idle_time),2) pct_busy
, round(100 * user_time /(busy_time + idle_time),2) pct_user
, round(100 * sys_time /(busy_time + idle_time),2) pct_sys
, round(100 * iowt_time /(busy_time + idle_time),2)  pct_iowt
, round(100 * cpuwt_time /(busy_time + idle_time),2) pct_cpuwt
, host_name 
, (select get_instance_name from dual) as instance_name
from
  (
    select
      snap_id
    , snap_time
    , load
    , decode(prev_busyt
             , - 1
             , to_number(null)
             , busyt - prev_busyt) busy_time
    , decode(prev_idlet
             , - 1
             , to_number(null)
             , idlet - prev_idlet) idle_time
    , decode(prev_usert
             , - 1
             , to_number(null)
             , usert - prev_usert) user_time
    , decode(prev_syst
             , - 1
             , to_number(null)
             , syst - prev_syst)   sys_time
    , decode(prev_iowt
             , - 1
             , to_number(null)
             , iowt - prev_iowt)   iowt_time
    , decode(prev_cpuwt
             , - 1
             , to_number(null)
             , cpuwt - prev_cpuwt) cpuwt_time
    , host_name         
    from
      (
        select -- lag
          snap_id
        , load
        , snap_time
        , busyt
        , ( lag(busyt, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_busyt
        , idlet
        , ( lag(idlet, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_idlet
        , usert
        , ( lag(usert, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_usert
        , syst
        , ( lag(syst, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_syst
        , iowt
        , ( lag(iowt, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_iowt
        , cpuwt
        , ( lag(cpuwt, 1, - 1)
              over(
            order by
              snap_id asc
              ) ) prev_cpuwt
        , host_name
        from
          ( (
            select
              s.snap_id
            , sn.stat_name
            , to_char(ss.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time
            , s.value
            , di.host_name
            from perfstat.stats$osstat     s
            inner join perfstat.stats$osstatname sn
            on sn.osstat_id = s.osstat_id
            inner join perfstat.stats$snapshot   ss
            on ss.snap_id = s.snap_id 
               and ss.dbid = s.dbid 
               and ss.instance_number = s.instance_number
            inner join perfstat.stats$database_instance di
            on s.dbid = di.dbid    
            where sn.stat_name in ( 'LOAD', 'IDLE_TIME', 'BUSY_TIME', 'USER_TIME', 'SYS_TIME'
                                  , 'IOWAIT_TIME', 'CPU_WAIT_TIME' )

              and ss.snap_time between trunc(sysdate-30) and sysdate
          ) pivot (
            sum(value)
            for stat_name
            in ( 'LOAD' load, 'IDLE_TIME' idlet, 'BUSY_TIME' busyt, 'USER_TIME' usert, 'SYS_TIME' syst, 'IOWAIT_TIME' iowt, 'CPU_WAIT_TIME'
            cpuwt )
          )
          )
      )
  )
order by snap_id