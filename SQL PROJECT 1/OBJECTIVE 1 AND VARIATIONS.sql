------ Objective 1: Identify by name the most popular journeys and their corresponding passenger counts.
--- Seems to be correct but I want to include the ID. 
SELECT j.name AS journey_name, COUNT(t.id_passenger) AS passenger_count
FROM public."JOURNEY" j
JOIN public."TRAVEL" t ON j.id = t.id_journey
GROUP BY j.name
ORDER BY passenger_count DESC
LIMIT 5;



----- Objective 1: Identify by name and id the most popular journeys and their corresponding passenger counts.

SELECT t.id_journey AS journey_id, j.name AS journey_name, COUNT(t.id_passenger) AS passenger_count
FROM public."JOURNEY" j
JOIN public."TRAVEL" t ON j.id = t.id_journey
GROUP BY  j.name, t.id_journey
ORDER BY passenger_count DESC
LIMIT 10;

------ Looks like there's a problem with the database. Although both previous codes have to execute the same result, when grouping by id the count of passenger is lower. 
------ It seems that there's a discrepancy on ID's on TRAVEL table. To correct that issue of having different IDs for the same journey or route in the travel table on, let's try to Join them by the name not the id.

SELECT j.id AS journey_id, j.name AS journey_name, COUNT(t.id_passenger) AS passenger_count
FROM public."JOURNEY" j
JOIN public."TRAVEL" t ON j.name = (SELECT name FROM public."JOURNEY" WHERE id = t.id_journey)
GROUP BY j.id, j.name
ORDER BY passenger_count DESC
LIMIT 10;

---- Another try, but correcting the fact that it's retrieving the same route 10 times but with different ID
---- In this case i will  modify the query to use a subquery that retrieves the maximum journey ID for each unique journey name.

SELECT j.id AS journey_id, j.name AS journey_name, COUNT(t.id_passenger) AS passenger_count
FROM public."JOURNEY" j
JOIN (
  SELECT id_journey, MAX(id) AS max_id
  FROM public."TRAVEL"
  GROUP BY id_journey
) tmax ON j.id = tmax.id_journey
JOIN public."TRAVEL" t ON tmax.max_id = t.id
GROUP BY j.id, j.name
ORDER BY passenger_count DESC
LIMIT 10;

---- It was not possible to include the ID, so I will have to correct the IDs. I will describe the process:
-- Step 1: Delete the id column and add a new column to the journey table as a unique identifier
ALTER TABLE public."JOURNEY"
DROP id
ALTER TABLE public."JOURNEY"
ADD COLUMN journey_id serial PRIMARY KEY;

-- Step 2: Update the journey table to assign unique IDs
UPDATE public."JOURNEY"
SET journey_id = DEFAULT;

-- Step 3: Add a new foreign key column referencing the journey_id in the journey table
ALTER TABLE public."TRAVEL"
ADD COLUMN journey_id integer;

-- Step 5: Update the journey_id in the travel table based on the journey name
UPDATE public."TRAVEL" AS t
SET journey_id = j.journey_id
FROM public."JOURNEY" AS j
WHERE t.journey_name = j.name;

-- Step 6: Remove the journey_name column from the travel table
ALTER TABLE public."TRAVEL"
DROP COLUMN journey_name;

-- Step 7: Add a foreign key constraint to link the journey_id in the travel table to the journey table
ALTER TABLE public."TRAVEL"
ADD CONSTRAINT fk_travel_journey_id FOREIGN KEY (journey_id) REFERENCES public."JOURNEY"(journey_id);

--- Now, the previous code for objective 1 shoul be able to work.
-- Objective 1: Identify the most popular journeys and their corresponding passenger counts.

SELECT j.journey_id AS journey_id, j.name AS journey_name, COUNT(t.id) AS passenger_count
FROM public."JOURNEY" j
JOIN public."TRAVEL" t ON j.journey_id = t.journey_id
GROUP BY j.journey_id, j.name
ORDER BY passenger_count DESC
LIMIT 10;

--- Now it works :)
