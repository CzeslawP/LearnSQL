1. Korzystając ze składni CREATE ROLE, stwórz nowego użytkownika o nazwie user_training z
możliwością zalogowania się do bazy danych i hasłem silnym :) (coś wymyśl).
2. Korzystając z atrybutu AUTHORIZATION dla składni CREATE SCHEMA. Utwórz schemat
training, którego właścicielem będzie użytkownik user_training.
3. Będąc zalogowany na super użytkowniku postgres, spróbuj usunąć rolę (użytkownika)
user_training

CREATE ROLE user_training PASSWORD 'afgjkhasjkdvncmbx';
GRANT CONNECT ON DATABASE postgres TO user_training;

CREATE SCHEMA training AUTHORIZATION user_training;

4. Przekaż własność nad utworzonym dla / przez użytkownika user_training obiektami na role
postgres. Następnie usuń role user_training.

ALTER SCHEMA training OWNER TO postgres;

REVOKE ALL PRIVILEGES 
ON DATABASE postgres
FROM user_training;

DROP USER user_training;


5. Utwórz nową rolę reporting_ro, która będzie grupą dostępów, dla użytkowników warstwy
analitycznej o następujących przywilejach.
 Dostęp do bazy danych postgres
 Dostęp do schematu training
 Dostęp do tworzenia obiektów w schemacie training
 Dostęp do wszystkich uprawnień dla wszystkich tabel w schemacie training
6. Utwórz nowego użytkownika reporting_user z możliwością logowania się do bazy danych i
haśle silnym :) (coś wymyśl). Przypisz temu użytkownikowi role reporting ro;

--ROLE CREATION
CREATE ROLE reporting_ro;
GRANT CONNECT ON DATABASE postgres TO reporting_ro; 
GRANT USAGE ON SCHEMA training TO reporting_ro;
GRANT CREATE ON SCHEMA training TO reporting_ro;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA training TO reporting_ro;

--USER CREATION
CREATE ROLE reporting_user login PASSWORD 'passsssword';
GRANT reporting_ro TO reporting_user;

--LOG IN AS USER - ATTEMPT:
--SCHEMA TRAINING
CREATE TABLE training.newtable (id integer);
DROP TABLE training.newtable;
--SCHEMA PUBLIC
CREATE TABLE public.newtable (id integer);
DROP TABLE public.newtable;

--USER DELETION
REVOKE ALL PRIVILEGES ON DATABASE postgres FROM reporting_user;
DROP USER reporting_user;

--ROLE DELETION
REVOKE ALL PRIVILEGES ON DATABASE postgres FROM reporting_ro;
REVOKE CREATE, USAGE ON SCHEMA training FROM reporting_ro;
DROP ROLE reporting_ro;

7. Będąc zalogowany na użytkownika reporting_user, spróbuj utworzyć nową tabele (dowolną)
w schemacie training.


8. Zabierz uprawnienia roli reporting_ro do tworzenia obiektów w schemacie training;


9. Zaloguj się ponownie na użytkownika reporting_user, sprawdź czy możesz utworzyć nową
tabelę w schemacie training oraz czy możesz taką tabelę utworzyć w schemacie public.
