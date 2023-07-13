-- Pasajeros que realizaron un viaje

SELECT * FROM public."PASSENGERS"
INNER JOIN public."TRAVEL" ON (id_passenger = public."PASSENGERS".id);

-- Pasajeros que no realizaron viaje

SELECT * FROM public."PASSENGERS"
LEFT JOIN public."TRAVEL" ON (id_passenger = public."PASSENGERS".id)
WHERE public."TRAVEL".id = NULL;

-- Viajes sin pasajeros

SELECT * FROM public."PASSENGERS"
RIGHT JOIN public."TRAVEL" ON (id_passenger = public."PASSENGERS".id)
WHERE public."PASSENGERS".id = NULL;

-- Todos los trenes sin ruta y rutas sin tren

SELECT * FROM public."TRAIN"
FULL OUTER JOIN public."JOURNEY" ON (id_train = public."TRAIN".id)
WHERE public."TRAIN".id = NULL 
OR public."JOURNEY".id = NULL;
