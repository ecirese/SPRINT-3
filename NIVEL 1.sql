-- NIVEL1 
-- Ejercicio 2.El departament de Recursos Humans ha identificat un error en el número de compte de l'usuari amb ID CcU-2938. 
-- La informació que ha de mostrar-se per a aquest registre és: R323456312213576817699999. Recorda mostrar que el canvi es va realitzar.

-- hacer el cambio de iban

UPDATE credit_card
SET iban = REPLACE(iban, 'TR301950312213576817638661', 'R323456312213576817699999')
WHERE id = 'CcU-2938';

-- verificar que está OK
SELECT *
FROM credit_card
WHERE id = 'CcU-2938';

-- Ejercicio 3. En la taula "transaction" ingressa un nou usuari amb la següent informació:

INSERT INTO transaction (Id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0');

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`transactions`.`transaction`, CONSTRAINT `transaction_ibfk_1` 
-- FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)) -> Necesito primero insertar la companía en tabla company

INSERT INTO company (id, company_name, country, phone, email, website)
VALUES ('b-9999', 'Nueva Compañía de Prueba', 'Desconocido', 'N/A', 'info@nuevacompania.com', 'http://www.nuevacompania.com');
-- Relleno los otros campos con valores creados relevantes

-- verifico si existe el id en credit_card
select*
from credit_card
where id = 'CcU-9999';

-- no existe, lo creo

INSERT INTO credit_card (id, iban, pin, cvv, expiring_date)
VALUES ('CcU-9999', 'ES991234567890123456789012', '3257', '984', '2028-12-31');

-- Inserto la transacción.
INSERT INTO transaction (Id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0');

-- Ejercicio 4. Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_*card. Recorda mostrar el canvi realitzat.

ALTER TABLE credit_card
DROP COLUMN pan;

