exec dbms_scheduler.purge_log();

begin
  dbms_scheduler.create_schedule
    (
      schedule_name => 'AUTO_COLLECT_STATS'
      , start_date => trunc(sysdate)
      , repeat_interval =>'FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=0,10,20,30,40,50;BYSECOND=0'
      , comments => 'Scheduler for collecting statspack data from several sources.'
    );
end;
/

begin
  dbms_scheduler.create_program
    (
      program_name => 'RUN_COLLECT'
      ,program_type => 'STORED_PROCEDURE'
      ,program_action => 'ORAMON_PKG.collect_statspack_stats'
      ,enabled => true
      ,comments => 'Call stored procedure'
    );
end;
/

begin
  dbms_scheduler.create_job
    (
      job_name => 'AUTO_STATSPACK_COLLECT_JOB'
      , program_name => 'RUN_COLLECT'
      , schedule_name =>'AUTO_COLLECT_STATS'
      , enabled => true
      , auto_drop => true
      , comments => 'Job for collecting statspack data from several database instances'
    );
end;
/


--BEGIN
--DBMS_SCHEDULER.set_attribute( name => '"ORAMON"."AUTO_STATSPACK_COLLECT_JOB"', attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_FULL);
--
--        DBMS_SCHEDULER.set_attribute( name => '"ORAMON"."AUTO_STATSPACK_COLLECT_JOB"', attribute => 'auto_drop', value => FALSE);
--
--        DBMS_SCHEDULER.set_attribute( name => '"ORAMON"."AUTO_STATSPACK_COLLECT_JOB"', attribute => 'restartable', value => TRUE);
--
--END;
--/

begin
dbms_scheduler.set_scheduler_attribute('DEFAULT_TIMEZONE', 'Europe/Stockholm');
end;
/

commit;
