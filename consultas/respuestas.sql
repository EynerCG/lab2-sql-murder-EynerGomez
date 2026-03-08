

-- 1. Identificación detallada del asesinato; la descripción revela la existencia
--    de dos testigos clave.
    SELECT * FROM crime_scene_report
	WHERE date = 20180115 
	AND city = "SQL City" AND type = 'murder';

-- 2. Identificación del primer testigo: la persona que vive en la numeración más alta
-- de 'Northwestern Dr'.
    SELECT * FROM person
	WHERE address_street_name = 'Northwestern Dr'
	ORDER BY address_number DESC
    LIMIT 1;

-- 3. Consulta del testimonio del primer testigo (ID 14887) para obtener pistas
--    sobre el asesino.
    SELECT * FROM interview
	WHERE person_id = 14887;

-- 4. Localización de la segunda testigo, identificada por su nombre (Annabel)
--    y su calle (Franklin Ave).
    SELECT * FROM person
    WHERE address_street_name = 'Franklin Ave' AND name LIKE '%Annabel%';

-- 5. Consulta del testimonio de la segunda testigo usando su ID (16371).
    SELECT * FROM interview 
    WHERE person_id = 16371;

-- 6. Datos que conocemos del asesino e identificacion
    SELECT *
    FROM get_fit_now_member G
    INNER JOIN get_fit_now_check_in C ON G.id = C.membership_id
    INNER JOIN person P ON P.id = G.person_id
    INNER JOIN drivers_license L ON L.id = P.license_id
    WHERE C.check_in_date = '20180109'
    AND G.membership_status = 'gold'
    AND G.id LIKE '48Z%'
    AND L.gender = 'male'
    AND L.plate_number LIKE '%H42W%'

-- 7. Análisis de la entrevista del asesino
    SELECT p.name, i.*
    FROM interview i
    JOIN person p ON i.person_id = p.id
    WHERE i.person_id IN (67318);

-- 8. Consulta para hallar a la autora intelectual
    SELECT p.name
    FROM person p
    JOIN drivers_license dl ON p.license_id = dl.id
    JOIN facebook_event_checkin fec ON p.id = fec.person_id
    JOIN income i ON p.ssn = i.ssn
    WHERE dl.hair_color = 'red' 
    AND dl.car_make = 'Tesla' 
    AND dl.car_model = 'Model S'
    AND fec.event_name = 'SQL Symphony Concert'
    AND fec.date LIKE '201712%'
    GROUP BY p.name
    HAVING COUNT(*) = 3;
