SELECT * FROM  
  (SELECT
      CONCAT(cl.TABLE_NAME, ' [', cl.COLUMN_NAME, ', ', cl.COLUMN_TYPE, ']') tableRowType
    FROM information_schema.columns cl,  information_schema.TABLES ss
    WHERE
      cl.TABLE_NAME = ss.TABLE_NAME AND
      cl.TABLE_SCHEMA = 'database_one' AND
      ss.TABLE_TYPE IN('BASE TABLE', 'VIEW')
    ORDER BY
      cl.table_name ) AS t1
LEFT JOIN                     
  (SELECT
      CONCAT(cl.TABLE_NAME, ' [', cl.COLUMN_NAME, ', ', cl.COLUMN_TYPE, ']') tableRowType
    FROM information_schema.columns cl,  information_schema.TABLES ss
    WHERE
      cl.TABLE_NAME = ss.TABLE_NAME AND
      cl.TABLE_SCHEMA = 'database_two' AND
      ss.TABLE_TYPE IN('BASE TABLE', 'VIEW')
    ORDER BY
      cl.table_name ) AS t2 ON t1.tableRowType = t2.tableRowType
WHERE 
  t2.tableRowType IS NULL        
UNION 
SELECT * FROM  
  (SELECT
      CONCAT(cl.TABLE_NAME, ' [', cl.COLUMN_NAME, ', ', cl.COLUMN_TYPE, ']') tableRowType
    FROM information_schema.columns cl,  information_schema.TABLES ss
    WHERE
      cl.TABLE_NAME = ss.TABLE_NAME AND
      cl.TABLE_SCHEMA = 'database_one' AND
      ss.TABLE_TYPE IN('BASE TABLE', 'VIEW')
    ORDER BY
      cl.table_name ) AS t1
RIGHT JOIN                     
  (SELECT
      CONCAT(cl.TABLE_NAME, ' [', cl.COLUMN_NAME, ', ', cl.COLUMN_TYPE, ']') tableRowType
    FROM information_schema.columns cl,  information_schema.TABLES ss
    WHERE
      cl.TABLE_NAME = ss.TABLE_NAME AND
      cl.TABLE_SCHEMA = 'database_two' AND
      ss.TABLE_TYPE IN('BASE TABLE', 'VIEW')
    ORDER BY
      cl.table_name ) AS t2 ON t1.tableRowType = t2.tableRowType
WHERE 
  t1.tableRowType IS NULL;