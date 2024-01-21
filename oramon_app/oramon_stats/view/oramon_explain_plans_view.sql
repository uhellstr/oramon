CREATE OR REPLACE FORCE EDITIONABLE VIEW "ORAMON_STATS"."ORAMON_EXPLAIN_PLANS" 
 ( "OPERATION", "DEPTH", "OBJECT_NAME", "OBJECT_ALIAS", "CARDINALITY", "BYTES", "COST"
  )  AS 
  SELECT lpad(' ', 1 * ( depth - 1 ))
     || operation AS operation,
       depth,
       object_name,
       object_alias,
       cardinality,
       bytes,
       cost
FROM   stats$sql_plan