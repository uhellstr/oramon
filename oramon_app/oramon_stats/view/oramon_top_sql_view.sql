CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_TOP_SQL" 
 ( "SNAP_ID", "LAST_ACTIVE_TIME", "SQL_ID", "TEXT_SUBSET", "EXECUTIONS", "APPLICATION_WAIT_TIME", "CONCURRENCY_WAIT_TIME", "CLUSTER_WAIT_TIME", "USER_IO_WAIT_TIME", "ELAPSED_TIME", "ELAPSED_TIME/EXECUTIONS", "HOST_NAME", "INSTANCE_NAME"
  )  AS 
  select snap_id
       ,last_active_time
       ,sql_id
       ,text_subset
       ,executions
       ,application_wait_time
       ,concurrency_wait_time
       ,cluster_wait_time
       ,user_io_wait_time
       ,elapsed_time
       ,"ELAPSED_TIME/EXECUTIONS"
       ,host_name
       ,(select get_instance_name from dual) as instance_name
from (
            select ss.snap_id
                ,ss.last_active_time
                ,ss.sql_id
                ,ss.text_subset
                ,ss.executions
                ,ss.application_wait_time
                ,ss.concurrency_wait_time
                ,ss.cluster_wait_time
                ,ss.user_io_wait_time
                ,ss.elapsed_time
                ,ss.elapsed_time/executions as "ELAPSED_TIME/EXECUTIONS"
                ,di.host_name
            from stats$sql_summary ss
            inner join perfstat.stats$database_instance di
            on ss.dbid = di.dbid
            where
                ss.last_active_time >= trunc(sysdate)
                and ss.last_active_time <=  sysdate
                and ss.executions > 0
            order by "ELAPSED_TIME/EXECUTIONS" desc
        ) 
where rownum <=10 order by last_active_time asc