-- Objective 2: Calculate the average travel duration for each train model.

SELECT tr.model, AVG(EXTRACT(EPOCH FROM (t."end" - t.start))) AS average_duration
FROM public."TRAIN" tr
JOIN public."JOURNEY" j ON tr.id = j.id_train
JOIN public."TRAVEL" t ON j.journey_id = t.journey_id
GROUP BY tr.model;