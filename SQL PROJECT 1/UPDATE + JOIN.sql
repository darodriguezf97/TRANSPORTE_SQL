-- CORRECCION DE FECHA DE NACIMIENTO

UPDATE public."PASSENGERS"
	SET birth_date= public."CORRECT_BIRTH_DATE".correct_birth_date
	FROM public."CORRECT_BIRTH_DATE"
	WHERE public."PASSENGERS".id = public."CORRECT_BIRTH_DATE".id;