--------------------- Tables creation -------------------------

-------- PASSENGERS

CREATE TABLE IF NOT EXISTS public."PASSENGERS"
(
    id integer NOT NULL DEFAULT nextval('"PASSANGERS_id_seq"'::regclass),
    name character varying COLLATE pg_catalog."default",
    residence_adress character varying COLLATE pg_catalog."default",
    birth_date date,
    CONSTRAINT passangers_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."PASSENGERS"
    OWNER to postgres;

--------- TRAIN

CREATE TABLE IF NOT EXISTS public."TRAIN"
(
    id integer NOT NULL DEFAULT nextval('"TRAIN_ID_seq"'::regclass),
    capacity integer,
    model character varying COLLATE pg_catalog."default",
    CONSTRAINT train_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."TRAIN"
    OWNER to postgres;
	
---------- STATION

CREATE TABLE IF NOT EXISTS public."STATION"
(
    id integer NOT NULL DEFAULT nextval('"STATION_ID_seq"'::regclass),
    name character varying COLLATE pg_catalog."default",
    adress character varying COLLATE pg_catalog."default",
    CONSTRAINT station_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."STATION"
    OWNER to postgres;
	
----------- TRAVEL

CREATE TABLE IF NOT EXISTS public."TRAVEL"
(
    id integer NOT NULL DEFAULT nextval('"TRAVEL_id_seq"'::regclass),
    id_passenger integer NOT NULL,
    id_journey integer,
    start timestamp with time zone,
    "end" timestamp with time zone,
    CONSTRAINT travel_pkey PRIMARY KEY (id),
    CONSTRAINT travel_journey_fk FOREIGN KEY (id_journey)
        REFERENCES public."JOURNEY" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT travel_passenger_fk FOREIGN KEY (id_passenger)
        REFERENCES public."PASSENGERS" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."TRAVEL"

------------ JOURNEY

CREATE TABLE IF NOT EXISTS public."JOURNEY"
(
    id integer NOT NULL DEFAULT nextval('"JOURNEY_id_seq"'::regclass),
    id_station integer NOT NULL,
    id_train integer,
    name character varying COLLATE pg_catalog."default",
    CONSTRAINT journey_pkey PRIMARY KEY (id),
    CONSTRAINT journey_station_fk FOREIGN KEY (id_station)
        REFERENCES public."STATION" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT journey_train_fk FOREIGN KEY (id_train)
        REFERENCES public."TRAIN" (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."JOURNEY"
    OWNER to postgres;
	
----------- MODIFICATION TABLE: CORRECT_BIRTH_DATE

CREATE TABLE IF NOT EXISTS public."CORRECT_BIRTH_DATE"
(
    correct_birth_date date,
    id integer NOT NULL DEFAULT nextval('"CORRECT_BIRTH_DATE_id_seq"'::regclass),
    CONSTRAINT "CORRECT_BIRTH_DATE_pkey" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."CORRECT_BIRTH_DATE"
    OWNER to postgres;

--------------------------------------------------------