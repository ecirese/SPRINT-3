-- Nivell 3
-- Ejercicio 1. Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar. 
-- Identificar el nombre de la FK en transaction.credit_card_id 
SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'transaction' AND TABLE_NAME = 'transaction' AND COLUMN_NAME = 'credit_card_id';

-- eliminar la FK temporalmente 

ALTER TABLE transaction 
DROP FOREIGN KEY fk_transaction_credit_card_id;

-- Lo mismo con FK credit_card
SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'transactions' AND TABLE_NAME = 'transaction' AND COLUMN_NAME = 'credit_card_id';

-- Modificar el tipo de dato de transaction.credit_card_id para que coincida con credit_card.id

ALTER TABLE transaction MODIFY COLUMN credit_card_id VARCHAR(20);

-- Verificar registros sin relación 
SELECT DISTINCT t.user_id
FROM transaction t
LEFT JOIN data_user du ON t.user_id = du.id
WHERE du.id IS NULL; -- Resultado: user_id = 9999

-- la columna permite NULLS. Sino debería permitir NULLs antes de actualizar
-- ALTER TABLE transaction MODIFY COLUMN user_id INT NULL;

-- Actualizar el valor inconsistente a NULL 
UPDATE transaction SET user_id = NULL WHERE user_id = 9999;

-- completo datos del usuario que no coincide entre ambas tablas

INSERT INTO data_user (id, name, surname, email, birth_date, country, city, postal_code, address)
VALUES (9999, 'Usuario Desconocido', 'Apellido Desconocido', 'desconocido_9999@example.com', '1900-01-01', 'N/A', 'N/A', 'N/A', 'N/A');


-- Repetir verificación para confirmar que no hay más inconsistencias
SELECT DISTINCT t.user_id FROM transaction t LEFT JOIN data_user du ON t.user_id = du.id WHERE du.id IS NULL; -- Devuelve 0 filas

-- Realizar procesos similares de limpieza para company_id y credit_card_id si se encuentran inconsistencias.
-- Añadir FK para user_id
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_user_id
FOREIGN KEY (user_id)
REFERENCES data_user (id);

-- Añadir FK para company_id 

ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_company_id
FOREIGN KEY (company_id)
REFERENCES company (id);

-- En credit_card_id no hay inconsistencias en el tipo de dato. No fue necesario implementar modificaciones.

-- Ejercicio 2.L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:

-- ID de la transacció, Nom de l'usuari/ària, Cognom de l'usuari/ària ,IBAN de la targeta de crèdit usada., Nom de la companyia de la transacció realitzada.
-- Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
-- Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.

CREATE VIEW InformeTecnico AS
SELECT
    transaction.id AS ID_de_la_transacción,
    data_user.name AS Nombre_del_Usuario,
    data_user.surname AS Apellido_del_Usuario,
    credit_card.iban AS Iban_TarjetaCredito,
    company.company_name AS Nombre_De_Compañía
FROM
    transaction 
JOIN
    data_user  ON transaction.user_id = data_user.id
JOIN
    credit_card ON transaction.credit_card_id = credit_card.id 
JOIN
    company ON transaction.company_id = company.id; 
    
    
    SELECT *
    From InformeTecnico
    order by ID_de_la_transacción DESC;
    