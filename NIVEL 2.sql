
-- Nivell 2

-- Ejercicio 1. Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.
select *
from transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

delete from transaction where id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- Ejercicio 2. La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
-- S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. 
-- Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: Nom de la companyia. Telèfon de contacte. 
-- País de residència. Mitjana de compra realitzat per cada companyia. Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.

CREATE VIEW VistaMarketing AS 
SELECT company_name as 'Nombre_de_la_compañía', phone as 'Teléfono_de _ontacto', country as 'País_de_residencia', AVG (amount) as 'Media_de_compra'
FROM company
JOIN transaction 
ON company.id = transaction.company_id
GROUP BY company_name, phone, country
ORDER BY AVG (amount) DESC;

-- Ejercicio 3. Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

SELECT *
FROM vistamarketing
WHERE País_de_residencia = 'Germany';