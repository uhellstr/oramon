REM
REM Schema and workspace for ORAMON app
REM Install in client database where APEX is installed
REM

DECLARE
  lv_count number := 0;
BEGIN

  SELECT COUNT(*)
  INTO lv_count
  FROM DBA_USERS
  WHERE USERNAME = 'ORAMON';

  IF lv_count > 0 THEN
    EXECUTE IMMEDIATE 'DROP USER ORAMON CASCADE';
  END IF;

END;
/

CREATE USER "ORAMON" IDENTIFIED BY "oracle"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER "ORAMON" QUOTA UNLIMITED ON "USERS";

-- ROLES

-- SYSTEM PRIVILEGES
GRANT CREATE JOB TO "ORAMON" ;
GRANT CREATE TRIGGER TO "ORAMON" ;
GRANT CREATE MATERIALIZED VIEW TO "ORAMON" ;
GRANT CREATE DIMENSION TO "ORAMON" ;
GRANT CREATE OPERATOR TO "ORAMON" ;
GRANT CREATE INDEXTYPE TO "ORAMON" ;
GRANT CREATE VIEW TO "ORAMON" ;
GRANT CREATE SESSION TO "ORAMON" ;
GRANT CREATE TABLE TO "ORAMON" ;
GRANT CREATE TYPE TO "ORAMON" ;
GRANT CREATE SYNONYM TO "ORAMON" ;
GRANT CREATE SEQUENCE TO "ORAMON" ;
--GRANT EXECUTE DYNAMIC MLE TO "ORAMON" ;
GRANT CREATE CLUSTER TO "ORAMON" ;
GRANT CREATE PROCEDURE TO "ORAMON" ;
GRANT CREATE DATABASE LINK TO "ORAMON";

-- grants
--
grant select on perfstat.STATS$PROPAGATION_RECEIVER to oramon;
grant select on perfstat.STATS$BUFFERED_QUEUES to oramon;
grant select on perfstat.STATS$BUFFERED_SUBSCRIBERS to oramon;
grant select on perfstat.STATS$RULE_SET to oramon;
grant select on perfstat.STATS$OSSTATNAME to oramon;
grant select on perfstat.STATS$OSSTAT to oramon;
grant select on perfstat.STATS$PROCESS_ROLLUP to oramon;
grant select on perfstat.STATS$PROCESS_MEMORY_ROLLUP to oramon;
grant select on perfstat.STATS$SGA_TARGET_ADVICE to oramon;
grant select on perfstat.STATS$STREAMS_POOL_ADVICE to oramon;
grant select on perfstat.STATS$MUTEX_SLEEP to oramon;
grant select on perfstat.STATS$DYNAMIC_REMASTER_STATS to oramon;
grant select on perfstat.STATS$TEMP_SQLSTATS to oramon;
grant select on perfstat.STATS$IOSTAT_FUNCTION_NAME to oramon;
grant select on perfstat.STATS$IOSTAT_FUNCTION to oramon;
grant select on perfstat.STATS$IOSTAT_FUNCTION_DETAIL to oramon;
grant select on perfstat.STATS$MEMORY_TARGET_ADVICE to oramon;
grant select on perfstat.STATS$MEMORY_DYNAMIC_COMPS to oramon;
grant select on perfstat.STATS$SQL_PLAN_USAGE to oramon;
grant select on perfstat.STATS$SQL_PLAN to oramon;
grant select on perfstat.STATS$SEG_STAT to oramon;
grant select on perfstat.STATS$SEG_STAT_OBJ to oramon;
grant select on perfstat.STATS$PGASTAT to oramon;
grant select on perfstat.STATS$PARAMETER to oramon;
grant select on perfstat.STATS$INSTANCE_RECOVERY to oramon;
grant select on perfstat.STATS$STATSPACK_PARAMETER to oramon;
grant select on perfstat.STATS$SHARED_POOL_ADVICE to oramon;
grant select on perfstat.STATS$SQL_WORKAREA_HISTOGRAM to oramon;
grant select on perfstat.STATS$PGA_TARGET_ADVICE to oramon;
grant select on perfstat.STATS$JAVA_POOL_ADVICE to oramon;
grant select on perfstat.STATS$THREAD to oramon;
grant select on perfstat.STATS$FILE_HISTOGRAM to oramon;
grant select on perfstat.STATS$EVENT_HISTOGRAM to oramon;
grant select on perfstat.STATS$TIME_MODEL_STATNAME to oramon;
grant select on perfstat.STATS$SYS_TIME_MODEL to oramon;
grant select on perfstat.STATS$SESS_TIME_MODEL to oramon;
grant select on perfstat.STATS$STREAMS_CAPTURE to oramon;
grant select on perfstat.STATS$STREAMS_APPLY_SUM to oramon;
grant select on perfstat.STATS$PROPAGATION_SENDER to oramon;
grant select on perfstat.STATS$MEMORY_RESIZE_OPS to oramon;
grant select on perfstat.STATS$INTERCONNECT_PINGS to oramon;
grant select on perfstat.STATS$IDLE_EVENT to oramon;
grant select on perfstat.STATS$SYSTEM_EVENT to oramon;
grant select on perfstat.STATS$SESSION_EVENT to oramon;
grant select on perfstat.STATS$WAITSTAT to oramon;
grant select on perfstat.STATS$ENQUEUE_STATISTICS to oramon;
grant select on perfstat.STATS$SQL_SUMMARY to oramon;
grant select on perfstat.STATS$SQLTEXT to oramon;
grant select on perfstat.STATS$SQL_STATISTICS to oramon;
grant select on perfstat.STATS$RESOURCE_LIMIT to oramon;
grant select on perfstat.STATS$DLM_MISC to oramon;
grant select on perfstat.STATS$CR_BLOCK_SERVER to oramon;
grant select on perfstat.STATS$CURRENT_BLOCK_SERVER to oramon;
grant select on perfstat.STATS$INSTANCE_CACHE_TRANSFER to oramon;
grant select on perfstat.STATS$UNDOSTAT to oramon;
grant select on perfstat.STATS$DATABASE_INSTANCE to oramon;
grant select on perfstat.STATS$LEVEL_DESCRIPTION to oramon;
grant select on perfstat.STATS$SNAPSHOT to oramon;
grant select on perfstat.STATS$DB_CACHE_ADVICE to oramon;
grant select on perfstat.STATS$FILESTATXS to oramon;
grant select on perfstat.STATS$TEMPSTATXS to oramon;
grant select on perfstat.STATS$LATCH to oramon;
grant select on perfstat.STATS$LATCH_CHILDREN to oramon;
grant select on perfstat.STATS$LATCH_PARENT to oramon;
grant select on perfstat.STATS$LATCH_MISSES_SUMMARY to oramon;
grant select on perfstat.STATS$LIBRARYCACHE to oramon;
grant select on perfstat.STATS$BUFFER_POOL_STATISTICS to oramon;
grant select on perfstat.STATS$ROLLSTAT to oramon;
grant select on perfstat.STATS$ROWCACHE_SUMMARY to oramon;
grant select on perfstat.STATS$SGA to oramon;
grant select on perfstat.STATS$SGASTAT to oramon;
grant select on perfstat.STATS$SYSSTAT to oramon;
grant select on perfstat.STATS$SESSTAT to oramon;
grant select on perfstat.stats$system_event to oramon;
grant select on perfstat.stats$snapshot to oramon;
grant select on sys.v_$event_name to oramon;

-- profile
--
create profile ORAMON_DEFAULT_PROFILE LIMIT PASSWORD_LIFE_TIME UNLIMITED;
alter user ORAMON profile F1_DEFAULT_PROFILE;