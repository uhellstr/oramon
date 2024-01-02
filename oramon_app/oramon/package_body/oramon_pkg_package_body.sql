
  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "ORAMON"."ORAMON_PKG" as

/*
--******************************************************
--*                                                                                                        
--*    Created by:     Ulf Hellstrom, EpicoTech AB                         
--*    Date:           2023-12-07      
--*    Version:        1.0                                                        
--*    Updated by:    
--*    Description:    Collect statspack aggregated data 
--*                    from several database instances.
--*                
--*
--******************************************************
*/

  procedure get_oramon_cpuusage
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:    Collect cpuusage from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type cpuusage_rec is table of oramon_cpuusage%rowtype;
    l_cpuusage cpuusage_rec;
    
    
    lv_stmt_cpuusage clob := q'[select
                                 snap_id
                                 , snap_time
                                 , load
                                 , pct_busy
                                 , pct_user
                                 , pct_sys
                                 , pct_iowt
                                 , pct_cpuwt
                                 , host_name
                                 , instance_name
                               from oramon_cpuusage@{1}]';
                               
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_cpuusage,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_cpuusage;
    
    --dbms_output.put_line(l_memusage.count);
    
    for i in 1..l_cpuusage.count loop
      begin      
        insert into oramon_cpuusage 
        values  (l_cpuusage(i).snap_id
                ,l_cpuusage(i).snap_time
                ,l_cpuusage(i).load
                ,l_cpuusage(i).pct_busy
                ,l_cpuusage(i).pct_user
                ,l_cpuusage(i).pct_sys
                ,l_cpuusage(i).pct_iowt
                ,l_cpuusage(i).pct_cpuwt
                ,l_cpuusage(i).host_name
                ,l_cpuusage(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_cpuusage;

  --****************************************************************************

  procedure get_oramon_logons
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:    Collect logons from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type logons_rec is table of oramon_logons%rowtype;
    l_logons logons_rec;
    
    
    lv_stmt_logons clob := q'[select
                                snap_id
                                , snap_time
                                , value
                                , host_name
                                , instance_name
                              from oramon_logons@{1}]';
                               
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_logons,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_logons;
    
    --dbms_output.put_line(l_memusage.count);
    
    for i in 1..l_logons.count loop
      begin      
        insert into oramon_logons 
        values  (l_logons(i).snap_id
                ,l_logons(i).snap_time
                ,l_logons(i).value
                ,l_logons(i).host_name
                ,l_logons(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_logons;
  
  --****************************************************************************

  procedure get_oramon_exec_per_seconds
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:    Collect execs/s from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type exec_rec is table of oramon_exec_per_seconds%rowtype;
    l_execs exec_rec;
    
    
    lv_stmt_execs   clob := q'[select
                                 snap_id
                                 , snap_time
                                 , diff_value
                                 , exec_per_sec
                                 , host_name
                                 , instance_name
                               from oramon_exec_per_seconds@{1}]';                               
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_execs,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_execs;
    
    --dbms_output.put_line(l_execs.count);
    
    for i in 1..l_execs.count loop
      begin      
        insert into oramon_exec_per_seconds 
        values  (l_execs(i).snap_id
                ,l_execs(i).snap_time
                ,l_execs(i).diff_value
                ,l_execs(i).exec_per_sec
                ,l_execs(i).host_name
                ,l_execs(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_exec_per_seconds;

  --****************************************************************************

  procedure get_oramon_memusage
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:    Collect memory usage from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type memusage_rec is table of oramon_memusage%rowtype;
    l_memusage memusage_rec;
    
    
    lv_stmt_memusage clob := q'[select snap_id
                         ,snap_time
                         ,physical_memory_mb
                         ,free_memory_mb
                         ,inactive_memory_mb
                         ,swap_free_mb
                         ,host_name
                         ,instance_name
                         from oramon_memusage@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_memusage,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_memusage;
    
    --dbms_output.put_line(l_memusage.count);
    
    for i in 1..l_memusage.count loop
      begin      
        insert into oramon_memusage 
        values  (l_memusage(i).snap_id
                ,l_memusage(i).snap_time
                ,l_memusage(i).physical_memory_mb
                ,l_memusage(i).free_memory_mb
                ,l_memusage(i).inactive_memory_mb
                ,l_memusage(i).swap_free_mb
                ,l_memusage(i).host_name
                ,l_memusage(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_memusage;    

  --****************************************************************************

  procedure get_oramon_cursor_usage
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect open cursors from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type cursorusage_rec is table of oramon_open_cursors%rowtype;
    l_cursorusage cursorusage_rec;
    
    
    lv_stmt_cursorusage clob := q'[select
                                     snap_id
                                     , snap_time
                                     , value
                                     , host_name
                                     , instance_name
                                   from oramon_open_cursors@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_cursorusage,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_cursorusage;
    
    --dbms_output.put_line(l_cursorusage.count);
    
    for i in 1..l_cursorusage.count loop
      begin      
        insert into oramon_open_cursors 
        values  (l_cursorusage(i).snap_id
                ,l_cursorusage(i).snap_time
                ,l_cursorusage(i).value
                ,l_cursorusage(i).host_name
                ,l_cursorusage(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_cursor_usage;
  
  --****************************************************************************

  procedure get_oramon_sga
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect SGA stats from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type sga_rec is table of oramon_sga%rowtype;
    l_sga sga_rec;
    
    
    lv_stmt_sga clob := q'[select
                             snap_id
                             , snap_time
                             , component
                             , mb
                             , host_name
                             , instance_name
                           from oramon_sga@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_sga,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_sga;
    
    --dbms_output.put_line(l_cursorusage.count);
    
    for i in 1..l_sga.count loop
      begin      
        insert into oramon_sga 
        values  (l_sga(i).snap_id
                ,l_sga(i).snap_time
                ,l_sga(i).component
                ,l_sga(i).mb                
                ,l_sga(i).host_name
                ,l_sga(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_sga;
  
  --****************************************************************************

  procedure get_oramon_sga_memory
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect SGA memory stats from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type sga_rec is table of oramon_sga_memory%rowtype;
    l_sga sga_rec;
    
    
    lv_stmt_sga clob := q'[select
                             snap_id
                             , snap_time
                             , name
                             , bval
                             , host_name
                             , instance_name
                           from oramon_sga_memory@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_sga,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_sga;
    
    --dbms_output.put_line(l_sga.count);
    
    for i in 1..l_sga.count loop
      begin      
        insert into oramon_sga_memory 
        values  (l_sga(i).snap_id
                ,l_sga(i).snap_time
                ,l_sga(i).name
                ,l_sga(i).bval              
                ,l_sga(i).host_name
                ,l_sga(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_sga_memory;
  
  --****************************************************************************

  procedure get_oramon_wait_events
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect wait events stats from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type wait_rec is table of oramon_wait_events%rowtype;
    l_wait wait_rec;
    
    
    lv_stmt_wait clob := q'[select
                              snap_id
                              , snap_time
                              , event
                              , diff_value
                              , host_name
                              , instance_name
                            from oramon_wait_events@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_wait,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_wait;
    
    --dbms_output.put_line(l_sga.count);
    
    for i in 1..l_wait.count loop
      begin      
        insert into oramon_wait_events 
        values  (l_wait(i).snap_id
                ,l_wait(i).snap_time
                ,l_wait(i).event
                ,l_wait(i).diff_value             
                ,l_wait(i).host_name
                ,l_wait(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_wait_events;

  --****************************************************************************

  procedure get_oramon_buffer_hit_ratio
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect buffer hit ratio stats from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type buffer_rec is table of oramon_buffer_hit_ratio%rowtype;
    l_buffer buffer_rec;
    
    
    lv_stmt_wait clob := q'[select
                              snap_id
                              , snap_time
                              , buffer_hit
                              , host_name
                              , instance_name
                           from oramon_buffer_hit_ratio@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_wait,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_buffer;
    
    --dbms_output.put_line(l_sga.count);
    
    for i in 1..l_buffer.count loop
      begin      
        insert into oramon_buffer_hit_ratio 
        values  (l_buffer(i).snap_id
                ,l_buffer(i).snap_time
                ,l_buffer(i).buffer_hit             
                ,l_buffer(i).host_name
                ,l_buffer(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_buffer_hit_ratio;
  
  --****************************************************************************
  
  procedure get_oramon_buffer_pin_get_hit_ratio
    (
      p_in_dblink in varchar2
    )
  /*
  --******************************************************
  --*                                                                                                        
  --*    Created by:     Ulf Hellstrom, EpicoTech AB                         
  --*    Date:           2023-12-07      
  --*    Version:        1.0                                                        
  --*    Updated by:    
  --*    Description:   Collect buffer hit ratio stats from statspack      
  --*                   from several database instances.
  --*
  --******************************************************
  */    
  as

    type buffer_rec is table of oramon_buffer_pin_get_hit_ratio%rowtype;
    l_buffer buffer_rec;
    
    
    lv_stmt_wait clob := q'[select
                              snap_id
                              , snap_time
                              , pinhitrate
                              , gethitrate
                              , host_name
                              , instance_name
                            from oramon_buffer_pin_get_hit_ratio@{1}]';
    lv_stmt clob;

  begin

    lv_stmt := replace(lv_stmt_wait,'{1}',p_in_dblink);
    --dbms_output.put_line(lv_stmt);
    
    execute immediate lv_stmt bulk collect into l_buffer;
    
    --dbms_output.put_line(l_sga.count);
    
    for i in 1..l_buffer.count loop
      begin      
        insert into oramon_buffer_pin_get_hit_ratio
        values  (l_buffer(i).snap_id
                ,l_buffer(i).snap_time
                ,l_buffer(i).pinhitrate
                ,l_buffer(i).gethitrate
                ,l_buffer(i).host_name
                ,l_buffer(i).instance_name);
        commit;
      exception when dup_val_on_index then
        null;      
      end;    
    end loop;
    
  end get_oramon_buffer_pin_get_hit_ratio;
  
  --****************************************************************************
  -- Main starts here --

  procedure collect_statspack_stats as
  begin
    get_oramon_memusage(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_cpuusage(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_exec_per_seconds(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_logons(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_cursor_usage(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_sga(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_sga_memory(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_wait_events(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_buffer_hit_ratio(p_in_dblink => 'XEPDB1_DROPLET');
    get_oramon_buffer_pin_get_hit_ratio(p_in_dblink => 'XEPDB1_DROPLET');
  end collect_statspack_stats;

end oramon_pkg;