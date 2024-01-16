-- 615538388

select 
  sspu.snap_id
, sspu.dbid
, sspu.instance_number
, sspu.old_hash_value
, sspu.text_subset
, sspu.plan_hash_value --> 3468737115
, sspu.hash_value
, sspu.sql_id
, sspu.cost
, sspu.address
, sspu.optimizer
, sspu.last_active_time
from
  stats$sql_plan_usage sspu
where old_hash_value = 615538388
      and snap_id = 1877;
      
select
  snap_id
, dbid
, instance_number
, old_hash_value
, text_subset
, plan_hash_value --> 2048069931
, hash_value  --> 3468737115
, sql_id
, cost
, address
, optimizer
, last_active_time
from
  stats$sql_plan_usage
where old_hash_value = 615538388
      and snap_id = 1877;
      
select
  plan_hash_value
, id
, operation
, options
, object_node
, object#
, object_owner
, object_name
, object_alias
, object_type
, optimizer
, parent_id
, depth
, position
, search_columns
, cost
, cardinality
, bytes
, other_tag
, partition_start
, partition_stop
, partition_id
, other
, distribution
, cpu_cost
, io_cost
, temp_space
, access_predicates
, filter_predicates
, projection
, time
, qblock_name
, remarks
, snap_id
from
  stats$sql_plan
where snap_id = 1878;

-- Important to get the sql plan..

SELECT lpad(' ', 1 * ( depth - 1 ))
     || operation AS operation,
       depth,
       object_name,
       object_alias,
       cardinality,
       bytes,
       cost
FROM   stats$sql_plan
WHERE  plan_hash_value IN(SELECT plan_hash_value
                          FROM   stats$sql_plan_usage
                          WHERE  old_hash_value = 4194140317	
                                 AND snap_id BETWEEN 1861 AND 1862
                                 AND plan_hash_value > 0);