CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_MEMUSAGE" 
 ( "SNAP_ID", "SNAP_TIME", "PHYSICAL_MEMORY_MB", "FREE_MEMORY_MB", "INACTIVE_MEMORY_MB", "SWAP_FREE_MB", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select snap_id
       , snap_time
       , round(physical_memory_bytes / 1024 / 1024, 2) as physical_memory_mb
       , round(free_memory_bytes / 1024 / 1024, 2)     as free_memory_mb
       , round(inactive_memory_bytes / 1024 / 1024, 2) as inactive_memory_mb
       , round(swap_free_bytes / 1024 / 1024, 2)       as swap_free_mb
       , host_name
       , (select get_instance_name from dual) as instance_name
from
  (
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
    on ss.dbid = s.dbid
    and ss.snap_id = s.snap_id
    and ss.instance_number = s.instance_number
    inner join perfstat.stats$database_instance di
    on s.dbid = di.dbid
    where sn.stat_name in ( 'PHYSICAL_MEMORY_BYTES', 'FREE_MEMORY_BYTES', 'INACTIVE_MEMORY_BYTES', 'SWAP_FREE_BYTES' )
      and ss.snap_time between trunc(sysdate-30) and sysdate
  ) pivot (
    max(value)
    for stat_name
    in ( 'PHYSICAL_MEMORY_BYTES' as physical_memory_bytes, 'FREE_MEMORY_BYTES' as free_memory_bytes, 'INACTIVE_MEMORY_BYTES' as inactive_memory_bytes
    , 'SWAP_FREE_BYTES' as swap_free_bytes )
  )
order by snap_id