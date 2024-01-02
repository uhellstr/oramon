
  
BEGIN 
dbms_scheduler.disable1_calendar_check();
dbms_scheduler.create_schedule('AUTO_COLLECT_STATS',TO_TIMESTAMP_TZ('26-DEC-2023 12.00.00,000000000 AM EUROPE/STOCKHOLM','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'),
'FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23;BYMINUTE=0,10,20,30,40,50;BYSECOND=0;',
NULL,
'Scheduler for collecting statspack data from several sources.'
);
COMMIT; 
END; 
