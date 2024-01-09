create or replace view oramon_buffer_hit_ration as
select snap_id
       ,snap_time
       ,to_char(1-(physical_reads_cache/(consistent_gets_from_cache + db_block_gets_from_cache + recovery_block_gets_from_cache)),'0.000') buffer_hit 
       ,host_name
       ,(select get_instance_name from dual) as instance_name
from
(
select snap_id
      ,snap_time
      ,name
      ,diff_value
      ,host_name
from
(
select snap.snap_id
       ,to_char(snap.snap_time, 'RRRR-MM-DD HH24:MI:SS') snap_time 
       ,sys.name
       , sys.value - (lag( sys.value ) over ( partition by snap.dbid,snap.instance_number,snap.startup_time,sys.name order by snap.snap_id )) diff_value 
       ,di.host_name
from perfstat.stats$sysstat sys
inner join perfstat.stats$snapshot snap
on    sys.snap_id= snap.snap_id
inner join perfstat.stats$database_instance di
on snap.dbid = di.dbid
where sys.dbid   = snap.dbid
and sys.instance_number = snap.instance_number
and sys.name in ('physical reads cache','consistent gets from cache','db block gets from cache', 'recovery block gets from cache')
and snap.snap_time between trunc(sysdate-30) and sysdate
) 
where diff_value is not null -- AVOID DIVIZION BY ZERO
)
pivot (max(diff_value) for name in ('physical reads cache'             physical_reads_cache
                                    ,'consistent gets from cache'      consistent_gets_from_cache
                                    ,'db block gets from cache'        db_block_gets_from_cache
                                    , 'recovery block gets from cache' recovery_block_gets_from_cache
                                   )
)
order by snap_id;