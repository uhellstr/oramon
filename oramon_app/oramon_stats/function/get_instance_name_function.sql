
  CREATE OR REPLACE EDITIONABLE FUNCTION "ORAMON_STATS"."GET_INSTANCE_NAME" 
return varchar2 as

 lv_retval varchar2(30);

begin

  begin
  with type_of_instance as
  (
  select case sys_context('USERENV', 'CON_ID')
              when '0' then 'CDB' 
              when '1' then 'CDB' 
              else 'PDB' 
         end cdb_or_pdb
  from   dual
  )
  ,cdb_instance as
  (
  select instance_name as instance_name
  from v$instance
  ) 
  ,pdb_instance as
  (
  select name as instance_name
  from v$pdbs
  ) 
  select case cdb_or_pdb
           when 'PDB' then
             pdb_instance.instance_name
           when 'CDB' then
             cdb_instance.instance_name
         end instance_name into lv_retval
  from type_of_instance
       ,cdb_instance
       ,pdb_instance;

  exception
    when no_data_found then null;
  end;

  dbms_output.put_line('cdb_or_pdb lv_retval = '||lv_retval);

  -- standalone , no multitenant
  if lv_retval is null then
    select instance_name into lv_retval
    from v$instance;
  end if;

  dbms_output.put_line('standalone = '||lv_retval);

  return lv_retval;

end get_instance_name;