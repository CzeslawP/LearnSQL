Moduł 3 Data Definition Language – Zadania Teoria SQL
1. Utwórz nowy schemat o nazwie training.
2. Zmień nazwę schematu na training_zs;
3. Korzystając z konstrukcji <nazwa_schematy>.<nazwa_tabeli> lub łącząc się do schematu
training_zs, utwórz tabelę według opisu.
Tabela: products;
Kolumny:
 id - typ całkowity,
 production_qty - typ zmiennoprzecinkowy (numeric - 10 znaków i do 2 znaków po przecinku)
 product_name - typ tekstowy 100 znaków (varchar)
 product_code - typ tekstowy 10 znaków
 description - typ tekstowy nieograniczona ilość znaków
 manufacturing_date - typ data (sama data bez części godzin, minut, sekund)
4. Korzystając ze składni ALTER TABLE, dodaj klucz główny do tabeli products dla pola ID.
5. Korzystając ze składni IF EXISTS spróbuj usunąć tabelę sales ze schematu training_zs
6. W schemacie training_zs, utwórz nową tabelę sales według opisu.

ALTER SCHEMA training rename TO training_zs;

CREATE TABLE training_zs.products (
	id integer,
	production_qty NUMERIC,
	product_name varchar(100),
	product_code varchar(10),
	desciption TEXT,
	manufacturing_date date
);

ALTER TABLE training_zs.products
ALTER COLUMN production_qty SET DATA TYPE dec(10, 2);

ALTER TABLE training_zs.products ADD PRIMARY KEY (id);


DROP TABLE IF EXISTS trainig_zs.sales;

Tabela: sales;
Kolumny:
 id - typ całkowity, klucz główny,
 sales_date - typ data i czas (data + część godziny, minuty, sekundy), to pole ma nie zawierać
wartości nieokreślonych NULL,
 sales_amount - typ zmiennoprzecinkowy (NUMERIC 38 znaków, do 2 znaków po przecinku)
 sales_qty - typ zmiennoprzecinkowy (NUMERIC 10 znaków, do 2 znaków po przecinku)
 product_id - typ całkowity INTEGER
 added_by - typ tekstowy (nielimitowana ilość znaków), z wartością domyślną 'admin'
UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla kolumny
https://www.postgresql.org/docs/12/ddl-default.html
 Korzystając z definiowania przy tworzeniu tabeli, po definicji kolumn, dodaje ograniczenie o
nazwie sales_over_1k na polu sales_amount typu CHECK takie, że wartości w polu
sales_amount muszą być większe od 1000
7. Korzystając z operacji ALTER utwórz powiązanie między tabelą sales a products, jako klucz obcy
pomiędzy atrybutami product_id z tabeli sales i id z tabeli products. Dodatkowo nadaj kluczowi
obcemu opcję ON DELETE CASCADE
8. Korzystając z polecenia DROP i opcji CASCADE usuń schemat training_zs

CREATE TABLE training_zs.sales (
	id integer PRIMARY KEY,
	sales_date timestamp NOT NULL,
	sales_amount numeric(38, 2),
	sales_qty numeric(10, 2),
	product_id integer,
	added_by TEXT DEFAULT 'admin',
	CONSTRAINT sales_over_1k CHECK (sales_amount > 1000)
	);
	

ALTER TABLE training_zs.sales add FOREIGN KEY (product_id) REFERENCES training_zs.products(id) ON DELETE CASCADE;

DROP SCHEMA training_zs CASCADE;
	
	