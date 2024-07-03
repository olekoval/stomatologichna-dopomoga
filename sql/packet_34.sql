SELECT COUNT(patient_repetitions) AS кiлькiсть_унiкальних_пацієнтів,
       AVG(patient_repetitions) AS середня_кiлькiсть_емз_на_пацієнта
  FROM (
    SELECT COUNT(*) AS patient_repetitions 
      FROM analytics.rds_pmg_events_checks_2024 AS ech
           JOIN analytics.rds_pmg_events_2024 AS e ON e.id = ech.id             
     WHERE ech.packet_number = '34'
       AND ech.is_correct
       AND ech.is_payment
       AND e.age_years < 18
       AND EXTRACT(MONTH FROM e.starts) < 7
     GROUP BY e.patient_id
     ) AS t;
 

SELECT COUNT(patient_repetitions) AS кiлькiсть_унiкальних_пацієнтів,
       AVG(patient_repetitions) AS середня_кiлькiсть_емз_на_пацієнта
  FROM (
       SELECT COUNT(*) AS patient_repetitions 
       FROM (
              SELECT *
                FROM analytics.rds_pmg_events_2024 e
               WHERE EXISTS (SELECT 1 
                               FROM analytics.rds_pmg_events_checks_2024 ech
                              WHERE e.id = ech.id
                                AND ech.packet_number = '34'
                                AND ech.is_correct
                                AND ech.is_payment)
                     ) t
      WHERE e.age_years < 18
        AND EXTRACT(MONTH FROM e.starts) < 7
      GROUP BY e.patient_id) t2;

