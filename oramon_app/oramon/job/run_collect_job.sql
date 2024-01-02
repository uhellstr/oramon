
  

  
BEGIN 
dbms_scheduler.create_program('RUN_COLLECT','STORED_PROCEDURE',
'ORAMON_PKG.collect_statspack_stats'
,0, TRUE,
'Call stored procedure'
);
COMMIT; 
END; 
 
dbms_scheduler.create_program('RUN_COLLECT','STORED_PROCEDURE',
'ORAMON_PKG.collect_statspack_stats'
,0, TRUE,
'Call stored procedure'
);
COMMIT; 
END; 
