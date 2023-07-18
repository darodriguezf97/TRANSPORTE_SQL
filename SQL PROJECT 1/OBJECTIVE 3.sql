-- Objective 3: Determine the stations with the highest passenger traffic.

SELECT s.id AS station_id, s.name AS station_name, COUNT(t.id) AS passenger_count
FROM public."STATION" s
JOIN public."JOURNEY" j ON s.id = j.id_station
JOIN public."TRAVEL" t ON j.journey_id = t.journey_id
GROUP BY s.id, s.name
ORDER BY passenger_count DESC
LIMIT 10;
