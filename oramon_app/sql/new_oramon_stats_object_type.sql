create type t_top_sql_row as object (
  instance_number number,
  dbid number ,
	b_snap_id number , 
	e_snap_id number, 
	b_snap_time date , 
	e_snap_time date, 
	interval_min number, 
	dbtimemin number, 
	aas number, 
	hv number , 
	elapsed_time_sec number, 
	executions number, 
	elapsed_per_exec_sec number, 
	percent_of_dbtime_used number, 
	cpu_time_sec number, 
	cpu_time_ms_per_exec number, 
	physical_reads number, 
	physical_reads_per_execution number, 
	buffer_gets number, 
	gets_per_execution number, 
	rows_processed number, 
	rows_processed_per_execution number, 
	parse_calls number, 
	max_sharable_mem_kb number, 
	last_sharable_mem_kb number, 
	max_version_count number, 
	last_version_count number, 
	delta_version_count number, 
	cluster_wait_time_sec number, 
	cwt_percent_of_elapsed_time number, 
	avg_hard_parse_time_ms number, 
	module varchar2(64 byte), 
	sql_text varchar2(256 byte)
);
/

create type t_top_sql_tab is table of t_top_sql_row;
/
