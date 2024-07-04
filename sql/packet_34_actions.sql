SELECT kwd_name AS назва_інтервенції,
       act AS код,
       count_act AS кількість_випадків
  FROM (
		SELECT act,
			   COUNT(act) AS count_act
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
		 ) ac
        LEFT JOIN (SELECT code, kwd_name FROM core.dim_rpt_services WHERE is_current = 'Y' AND is_active) nm 
		       ON ac.act = nm.code
 ORDER BY count_act DESC	 
   
 
 