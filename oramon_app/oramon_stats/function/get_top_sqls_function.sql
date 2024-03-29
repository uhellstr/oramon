
  CREATE OR REPLACE EDITIONABLE FUNCTION "ORAMON_STATS"."GET_TOP_SQLS" 
                             (
                               p_start_time in varchar2
                              ,p_end_time in varchar2
                              ,p_top_n_by_attribute in varchar2
                             )

--                             
-- Example of usage:
-- select *
-- from table(get_top_sqls(p_start_time => '2024-01-10 00:00', p_end_time => '2024-01-10 14:22',p_top_n_by_attribute => 'elapsed_time'));
-- Valid parameters for p_top_n_by_attribute:
-- [elapsed_time | cpu_time | buffer_gets | disk_reads | executions | parse_calls | max_sharable_mem | max_version_count | cluster_wait_time]:
--

return t_top_sql_tab as

  l_tab             t_top_sql_tab             := t_top_sql_tab();
  top_n_sql         constant number           := 65;
  num_rows_per_hash constant number           := 1;
  top_pct_sql       constant number           := 1.0;

  l_dbid            stats$database_instance.dbid%type;
  l_instance_number stats$database_instance.instance_number%type;
  l_db_name         stats$database_instance.instance_name%type;
  l_instance_name   stats$database_instance.instance_name%type;
  l_host_name       stats$database_instance.host_name%type;


  cursor cur_get_dbid is
  select distinct 
         dbid            dbbid
       , instance_number instt_num
       , db_name         dbb_name
       , instance_name   instt_name
       , host_name       host
  from stats$database_instance
  order by instance_name, instance_number, dbid;

  cursor cur_get_top_sqls is
  select /*+ cursor_sharing_exact */ topn.instance_number, 
       topn.dbid,
       topn.b_snap_id, 
       topn.e_snap_id, 
       topn.b_snap_time, 
       topn.e_snap_time,
       topn.interval_min,
	     topn.DBtimemin,
	     topn.AAS,	   
       topn.old_hash_value hv,       
       round(delta_elapsed_time/1000000, 2) elapsed_time_sec,
       delta_executions executions,
       decode(delta_executions , 0, 0, round(delta_elapsed_time/1000000/delta_executions,2)) elapsed_per_exec_sec,
       decode(topn.dbtim, 0, 0 ,round(100*delta_elapsed_time/topn.dbtim, 2)) percent_of_dbtime_used,
       round(delta_cpu_time/1000000, 2) cpu_time_sec,       
       decode(delta_executions , 0, 0, round(delta_cpu_time/delta_executions/1000, 2)) cpu_time_ms_per_exec,        
       delta_disk_reads physical_reads,
       decode(delta_executions , 0, 0, round(delta_disk_reads/delta_executions, 2)) physical_reads_per_execution,       
       delta_buffer_gets buffer_gets, 
       decode(delta_executions , 0, 0, round(delta_buffer_gets/delta_executions, 2)) gets_per_execution, 
       delta_rows_processed rows_processed,
       decode(delta_executions , 0, 0, round(delta_rows_processed/delta_executions, 2)) rows_processed_per_execution,
       delta_parse_calls parse_calls,
       round(max_sharable_mem/1024, 2) max_sharable_mem_kb,
       round(last_sharable_mem/1024, 2) last_sharable_mem_kb,
       max_version_count,
       last_version_count,
       delta_version_count,
       round(delta_cluster_wait_time/1000000, 2) cluster_wait_time_sec,
       decode(delta_elapsed_time, 0, 0, round(100*delta_cluster_wait_time/delta_elapsed_time, 2)) cwt_percent_of_elapsed_time,
       round(avg_hard_parse_time/1000, 2) avg_hard_parse_time_ms,               
       topn.module,  
       translate(st.sql_text, chr(9) || chr(13) || chr(10), '   ') sql_text -- convert tabs and newlines to spaces   
  from ( select *
           from ( select gtt.*, 
                         row_number() over (partition by gtt.dbid, gtt.instance_number, gtt.e_snap_id 
                                                order by gtt.dbid, gtt.instance_number, gtt.e_snap_id, 
                                                         case when p_top_n_by_attribute = 'elapsed_time'      then delta_elapsed_time 
                                                              when p_top_n_by_attribute = 'cpu_time'          then delta_cpu_time
                                                              when p_top_n_by_attribute = 'buffer_gets'       then delta_buffer_gets
                                                              when p_top_n_by_attribute = 'disk_reads'        then delta_disk_reads
                                                              when p_top_n_by_attribute = 'executions'        then delta_executions
                                                              when p_top_n_by_attribute = 'parse_calls'       then delta_parse_calls
                                                              when p_top_n_by_attribute = 'max_sharable_mem'  then max_sharable_mem
                                                              when p_top_n_by_attribute = 'max_version_count' then max_version_count
                                                              when p_top_n_by_attribute = 'cluster_wait_time' then delta_cluster_wait_time
                                                              else delta_elapsed_time 
                                                          end desc
                                           ) rn
                    from 
                    (                                                 
                       with sysstat as
                             (
                                select /*consider enabling in case of TEMP TABLE TRANSFORMATION performance related issues: "qb_name(sysstat) inline"*/ * from
                                  (select instance_number, snap_id, dbid, name, value 
                                     from STATS$SYSSTAT 
                                    where name in ('physical reads', 
                                                   'session logical reads', 
                                                   'execute count', 
                                                   'parse count (total)'
                                                  )
                                  ) pivot
                                     (sum(value) for (name) in
                                             ('physical reads'                physical_reads,
                                              'session logical reads'  session_logical_reads,
                                              'execute count'                  execute_count,
                                              'parse count (total)'               tot_parses                 
                                              )
                                      )
                                ) ,
                       sys_time_model as (
                             select /*consider enabling in case of TEMP TABLE TRANSFORMATION performance related issues: "qb_name(sys_tm_model) inline"*/ * from
                               (select instance_number, snap_id, dbid, stat_name, value 
                                  from stats$sys_time_model stm, stats$time_model_statname tms                           
                                 where stm.stat_id = tms.stat_id
                                   and tms.stat_name in ('DB CPU', 'DB time')                                                    
                               ) pivot
                                  (sum(value) for (stat_name) in
                                          ('DB CPU'  dbcpu,
                                           'DB time' dbtime)
                                  )
                             ) ,                                                                                
                       snaps as
                        (select s.dbid, 
                               s.instance_number,                               
                               s.b b_snap_id, 
                               s.e e_snap_id, 
                               s.bt b_snap_time,
                               s.et e_snap_time, 
                               round((s.et - s.bt)*24*60,2) interval_min,              
                               sys_time_model_e.dbtime - sys_time_model_b.dbtime dbtim
                               , round((sys_time_model_e.dbtime - sys_time_model_b.dbtime)/1000000/60,2)  DBtimemin
                               , round(((sys_time_model_e.dbtime - sys_time_model_b.dbtime)/1000000/60)/((s.et - s.bt)*24*60),2) "AAS"
                               , s.esmt
                               , s.evc
                               , sysstat_e.session_logical_reads - sysstat_b.session_logical_reads session_logical_reads
                               , sysstat_e.physical_reads - sysstat_b.physical_reads  physical_reads
                               , sysstat_e.execute_count - sysstat_b.execute_count execute_count
                               , sysstat_e.tot_parses - sysstat_b.tot_parses tot_parses                                  
                               , sys_time_model_e.dbcpu - sys_time_model_b.dbcpu dbcpu
                               , i.parallel
                          from sys_time_model sys_time_model_b
                             , sys_time_model sys_time_model_e                                                                                                                    
                             , (select dbid, 
                                       instance_number, 
                                       snap_id b, 
                                       snap_time bt, 
                                       lead(snap_id) over (order by dbid, instance_number, snap_id) e, 
                                       lead(snap_time) over (order by dbid, instance_number, snap_id) et,                                        
                                       startup_time b_startup_time,
                                       lead(startup_time) over (order by dbid, instance_number, snap_id) e_startup_time,
                                       lead(sharable_mem_th) over (order by dbid, instance_number, snap_id) esmt, 
                                       lead(version_count_th) over (order by dbid, instance_number, snap_id) evc
                                  from stats$snapshot) s                             
                             , sysstat sysstat_b
                             , sysstat sysstat_e
                             , stats$database_instance i
                         where sys_time_model_b.snap_id           = s.b
                           and sys_time_model_b.instance_number   = s.instance_number
                           and sys_time_model_b.dbid              = s.dbid
                           and sys_time_model_e.snap_id           = s.e
                           and sys_time_model_e.instance_number   = s.instance_number
                           and sys_time_model_e.dbid              = s.dbid                                                                                                                                                                           
                           and s.b_startup_time                   = s.e_startup_time                                                                                 
                           and sysstat_b.snap_id                  = s.b                          
                           and sysstat_b.dbid                     = s.dbid
                           and sysstat_b.instance_number          = s.instance_number
                           and sysstat_e.snap_id                  = s.e                          
                           and sysstat_e.dbid                     = s.dbid
                           and sysstat_e.instance_number          = s.instance_number                                                                                                             
                           and i.dbid                             = s.dbid
                           and i.instance_number                  = s.instance_number
                           and i.startup_time                     = s.b_startup_time                                                                                
                           and s.dbid                             = l_dbid 
                           and s.instance_number = l_instance_number
                           and s.bt                              >= to_date(p_start_time,'RRRR-MM-DD HH24:MI')
                           and s.et                              <= to_date(p_end_time,'RRRR-MM-DD HH24:MI')
                        )    
                         select old_hash_value, s2.instance_number, s2.b_snap_id, s2.e_snap_id, s2.b_snap_time, 
                                s2.e_snap_time, s2.dbid, s2.interval_min, s2.dbtim, s2.dbcpu, s2.DBtimemin, 
                                s2.AAS, s2.session_logical_reads, s2.physical_reads, s2.execute_count, 
                                s2.tot_parses, lev1.text_subset, lev1.module,
                                lev1.delta_buffer_gets, lev1.delta_executions, lev1.delta_cpu_time, 
                                lev1.delta_elapsed_time, lev1.avg_hard_parse_time, lev1.delta_disk_reads, 
                                lev1.delta_parse_calls,
                                lev1.max_sharable_mem, lev1.last_sharable_mem,
                                lev1.delta_version_count, lev1.max_version_count, lev1.last_version_count,
                                lev1.delta_cluster_wait_time, lev1.delta_rows_processed, s2.parallel,
                                s2.esmt, s2.evc                                                            
                          from ( select -- sum deltas
                                        dbid,                                        
                                        snap_id, 
                                        instance_number,
                                        old_hash_value
                                      , text_subset
                                      , module
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address) 
                                                        or (buffer_gets < prev_buffer_gets)
                                                      then buffer_gets
                                                      else buffer_gets - prev_buffer_gets
                                                 end
                                           end)                    delta_buffer_gets
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (executions < prev_executions)
                                                      then executions
                                                      else executions - prev_executions
                                                 end
                                            end)                   delta_executions
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (cpu_time < prev_cpu_time)
                                                      then cpu_time
                                                      else cpu_time - prev_cpu_time
                                                 end
                                            end)                  delta_cpu_time
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (elapsed_time < prev_elapsed_time)
                                                      then elapsed_time
                                                      else elapsed_time - prev_elapsed_time
                                                 end
                                            end)                  delta_elapsed_time
                                      , avg(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else avg_hard_parse_time
                                            end)                  avg_hard_parse_time
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (disk_reads < prev_disk_reads)
                                                      then disk_reads
                                                      else disk_reads - prev_disk_reads
                                                 end
                                            end)                   delta_disk_reads
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (parse_calls < prev_parse_calls)
                                                      then parse_calls
                                                      else parse_calls - prev_parse_calls
                                                 end
                                            end)                   delta_parse_calls
                                      , max(sharable_mem)          max_sharable_mem
                                      , sum(case when snap_id = lev0.e_snap_id
                                                 then last_sharable_mem
                                                 else 0
                                            end)                   last_sharable_mem
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (version_count < prev_version_count)
                                                      then version_count
                                                      else version_count - prev_version_count
                                                 end
                                            end)                   delta_version_count
                                      , max(version_count)         max_version_count
                                      , sum(case when snap_id = lev0.e_snap_id
                                                 then last_version_count
                                                 else 0
                                            end)                   last_version_count
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (cluster_wait_time < prev_cluster_wait_time)
                                                      then cluster_wait_time
                                                      else cluster_wait_time - prev_cluster_wait_time
                                                 end
                                            end)                   delta_cluster_wait_time
                                      , sum(case
                                            when ((snap_id = lev0.b_snap_id and prev_snap_id = -1) or (snap_id not in (lev0.b_snap_id,lev0.e_snap_id))) 
                                            then 0
                                            else
                                                 case when (address != prev_address)
                                                        or (rows_processed < prev_rows_processed)
                                                      then rows_processed
                                                      else rows_processed - prev_rows_processed
                                                 end
                                            end)                   delta_rows_processed
                                  from (select /* commented out the first_rows hint from sprepins.sql - alternatively use "qb_name(sql_sum) index(s)" */ 
                                               snaps.dbid,
                                               s.snap_id,
                                               snaps.b_snap_id,
                                               snaps.e_snap_id,
                                               s.instance_number
                                             , old_hash_value
                                             , text_subset
                                             , module
                                             , (lag(snap_id, 1, -1) 
                                               over (partition by old_hash_value
                                                                , s.dbid
                                                                , s.instance_number
                                                    order by snap_id, b_snap_id))    prev_snap_id
                                             , (lead(snap_id, 1, -1)
                                               over (partition by old_hash_value
                                                                , s.dbid
                                                                , s.instance_number
                                                    order by snap_id, b_snap_id))    next_snap_id
                                             , address
                                             ,(lag(address, 1, hextoraw(0)) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_address
                                             , buffer_gets
                                             ,(lag(buffer_gets, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_buffer_gets
                                             , cpu_time
                                             ,(lag(cpu_time, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_cpu_time
                                             , executions
                                             ,(lag(executions, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_executions
                                             , elapsed_time
                                             ,(lag(elapsed_time, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_elapsed_time
                                             , avg_hard_parse_time
                                             , disk_reads
                                             ,(lag(disk_reads, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_disk_reads
                                             , parse_calls
                                             ,(lag(parse_calls, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_parse_calls
                                             , sharable_mem
                                             ,(last_value(sharable_mem) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   last_sharable_mem
                                             ,(lag(sharable_mem, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_sharable_mem
                                             , version_count
                                             ,(lag(version_count, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_version_count
                                             ,(last_value(version_count) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   last_version_count
                                             , cluster_wait_time
                                             ,(lag(cluster_wait_time, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_cluster_wait_time
                                             , rows_processed
                                             ,(lag(rows_processed, 1, 0) 
                                               over (partition by old_hash_value 
                                                                , s.dbid
                                                                , s.instance_number
                                                     order by snap_id, b_snap_id))   prev_rows_processed
                                        from stats$sql_summary s, snaps                                                                               
                                       where 
                                         ((s.snap_id = snaps.b_snap_id) or (s.snap_id = snaps.e_snap_id))
                                         and s.dbid            = snaps.dbid
                                         and s.instance_number = snaps.instance_number                                         
                                       ) lev0
                                group by dbid,
                                         instance_number ,
                                         snap_id, 
                                         old_hash_value
                                       , text_subset
                                       , module
                               ) lev1, snaps s2
                         where 
                           s2.instance_number = lev1.instance_number
                           and s2.dbid = lev1.dbid
                           and lev1.snap_id = s2.e_snap_id                            
                           and ( 
                               delta_buffer_gets       > 0
                            or delta_executions        > 0
                            or delta_cpu_time          > 0
                            or delta_disk_reads        > 0
                            or delta_parse_calls       > 0
                            or max_sharable_mem       >= s2.esmt
                            or max_version_count      >= s2.evc
                            or delta_cluster_wait_time > 0 )                    
                    ) gtt                    
                   where (p_top_n_by_attribute = 'elapsed_time'      and decode(gtt.dbtim, 0, 2, 100*delta_elapsed_time/gtt.dbtim) > decode(gtt.dbtim, 0, 1, top_pct_sql))
                      or (p_top_n_by_attribute = 'cpu_time'          and decode(gtt.dbcpu, 0, 2, null, 2, 100*delta_cpu_time/gtt.dbcpu) > decode(gtt.dbcpu, 0, 1, null, 2, top_pct_sql))                      
                      or (p_top_n_by_attribute = 'buffer_gets'       and 100*delta_buffer_gets/gtt.session_logical_reads > top_pct_sql )
                      or (p_top_n_by_attribute = 'disk_reads'        and gtt.physical_reads > 0 and 100*delta_disk_reads/gtt.physical_reads > top_pct_sql  )
                      or (p_top_n_by_attribute = 'executions'        and 100*delta_executions/gtt.execute_count > top_pct_sql )
                      or (p_top_n_by_attribute = 'parse_calls'       and 100*delta_parse_calls/gtt.tot_parses > top_pct_sql )
                      or (p_top_n_by_attribute = 'max_sharable_mem'  and max_sharable_mem > gtt.esmt)
                      or (p_top_n_by_attribute = 'max_version_count' and max_version_count > gtt.evc)
                      or (p_top_n_by_attribute = 'cluster_wait_time' and delta_cluster_wait_time > 0 and gtt.parallel  = 'YES') 
                ) x          
          where rn <= top_n_sql
          order by instance_number asc, 
                   b_snap_id asc,  
                   case when p_top_n_by_attribute = 'elapsed_time'      then delta_elapsed_time 
                        when p_top_n_by_attribute = 'cpu_time'          then delta_cpu_time
                        when p_top_n_by_attribute = 'buffer_gets'       then delta_buffer_gets
                        when p_top_n_by_attribute = 'disk_reads'        then delta_disk_reads
                        when p_top_n_by_attribute = 'executions'        then delta_executions
                        when p_top_n_by_attribute = 'parse_calls'       then delta_parse_calls
                        when p_top_n_by_attribute = 'max_sharable_mem'  then max_sharable_mem
                        when p_top_n_by_attribute = 'max_version_count' then max_version_count
                        when p_top_n_by_attribute = 'cluster_wait_time' then delta_cluster_wait_time
                        else delta_elapsed_time 
                    end desc
       ) topn
     , stats$sqltext st
 where st.old_hash_value(+) = topn.old_hash_value
   and st.text_subset(+)    = topn.text_subset   
   and st.piece             < num_rows_per_hash -- number of rows of SQL text to output    
 order by topn.instance_number asc, 
          topn.b_snap_id asc,                      
          case when p_top_n_by_attribute = 'elapsed_time'        then topn.delta_elapsed_time 
               when p_top_n_by_attribute = 'cpu_time'            then topn.delta_cpu_time
               when p_top_n_by_attribute = 'buffer_gets'         then topn.delta_buffer_gets
               when p_top_n_by_attribute = 'disk_reads'          then topn.delta_disk_reads
               when p_top_n_by_attribute = 'executions'          then topn.delta_executions
               when p_top_n_by_attribute = 'parse_calls'         then topn.delta_parse_calls
               when p_top_n_by_attribute = 'max_sharable_mem'    then topn.max_sharable_mem
               when p_top_n_by_attribute = 'max_version_count'   then topn.max_version_count
               when p_top_n_by_attribute = 'cluster_wait_time'   then topn.delta_cluster_wait_time
               else delta_elapsed_time 
           end desc,                    
          topn.old_hash_value, 
          st.piece;
begin

  open cur_get_dbid;
  fetch cur_get_dbid into l_dbid
                          ,l_instance_number
                          ,l_db_name
                          ,l_instance_name
                          ,l_host_name; 
  close cur_get_dbid;

  for rec in cur_get_top_sqls loop
    l_tab.extend;
    l_tab(l_tab.last) := t_top_sql_row(  rec.instance_number
                                        ,rec.dbid
                                        ,rec.b_snap_id
                                        ,rec.e_snap_id 
                                        ,rec.b_snap_time
                                        ,rec.e_snap_time
                                        ,rec.interval_min
                                        ,rec.dbtimemin
                                        ,rec.aas
                                        ,rec.hv
                                        ,rec.elapsed_time_sec
                                        ,rec.executions
                                        ,rec.elapsed_per_exec_sec
                                        ,rec.percent_of_dbtime_used
                                        ,rec.cpu_time_sec
                                        ,rec.cpu_time_ms_per_exec
                                        ,rec.physical_reads
                                        ,rec.physical_reads_per_execution
                                        ,rec.buffer_gets
                                        ,rec.gets_per_execution
                                        ,rec.rows_processed
                                        ,rec.rows_processed_per_execution
                                        ,rec.parse_calls
                                        ,rec.max_sharable_mem_kb
                                        ,rec.last_sharable_mem_kb
                                        ,rec.max_version_count
                                        ,rec.last_version_count
                                        ,rec.delta_version_count
                                        ,rec.cluster_wait_time_sec
                                        ,rec.cwt_percent_of_elapsed_time
                                        ,rec.avg_hard_parse_time_ms
                                        ,rec.module
                                        ,rec.sql_text
                                      );
  end loop;

  return l_tab;

end get_top_sqls;