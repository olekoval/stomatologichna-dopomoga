SELECT act AS інтервенція,
       COUNT(act) AS кількість_випадків
  FROM (
		SELECT unnest(actions) AS act
		  FROM analytics.rds_pmg_events_checks_2024 AS ech
				   JOIN analytics.rds_pmg_events_2024 AS e ON e.id = ech.id             
		 WHERE ech.packet_number = '34'
		   AND ech.is_correct
		   AND ech.is_payment
		   AND e.age_years < 18
		   AND EXTRACT(MONTH FROM e.starts) < 7
		   ) t
 GROUP BY act 
 ORDER BY кількість_випадків DESC;
   
 
 