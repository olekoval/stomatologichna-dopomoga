 
 
  FROM analytics.rds_pmg_events_2024 AS e
       JOIN analytics.rds_pmg_events_checks_2024 AS eh ON e.id = eh.id             
 WHERE eh.packet_number = '34'
   AND eh.is_correct
   AND age_years < 18
