INSERT INTO expence_tracker.bank_account_owner (owner_name, owner_desc, user_login)
	VALUES ('czesiek', 'user', 5645121);




CREATE TABLE expence_tracker.bank_account_types (
	id_ba_type SERIAL PRIMARY KEY,
	ba_type varchar(50) NOT NULL,
	ba_desc varchar(250),
	active boolean NOT NULL DEFAULT TRUE,
	is_common_account boolean NOT NULL DEFAULT FALSE,
	id_ba_own integer REFERENCES expence_tracker.bank_account_owner (id_ba_own),
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.bank_account_types (ba_type, ba_desc, id_ba_own)
	VALUES ('Barclays', 'Personal debit account', 1);


CREATE TABLE expence_tracker.transaction_bank_accounts (
	id_trans_ba SERIAL PRIMARY KEY,
	id_ba_own integer REFERENCES expence_tracker.BANK_ACCOUNT_OWNER (ID_BA_OWN),
	id_ba_typ integer REFERENCES expence_tracker.BANK_ACCOUNT_TYPES (ID_BA_TYPE),
	bank_account_name varchar(50) NOT NULL,
	bank_account_desc varchar(250),
	active boolean DEFAULT TRUE NOT null,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.transaction_bank_accounts (id_ba_own, bank_account_name, bank_account_desc)
	VALUES ('1', 'Barclays', 'Credit Card');

CREATE TABLE expence_tracker.transaction_category (
	id_trans_cat SERIAL PRIMARY KEY,
	category_name varchar(50) NOT NULL,
	category_desciption varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.transaction_category (category_name, category_desciption)
	VALUES ('Groceries', 'Food etc');


CREATE TABLE expence_tracker.transaction_subcategory (
	id_trans_subcat SERIAL PRIMARY KEY,
	id_trans_cat integer REFERENCES expence_tracker.TRANSACTION_CATEGORY (ID_TRANS_CAT),
	subcategory_name varchar(50) NOT NULL,
	subcategory_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description)
	VALUES (1, 'Food', 'Food for home cooking');
	

CREATE TABLE expence_tracker.transaction_type (
	id_trans_type SERIAL PRIMARY KEY,
	transaction_type_name varchar(50) NOT NULL,
	transaction_type_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.transaction_type (transaction_type_name, transaction_type_desc)
	VALUES ('Online purchase', 'Online purchase by card');

CREATE TABLE expence_tracker.users (
	id_user SERIAL PRIMARY KEY,
	user_login varchar(25) NOT NULL,
	user_name varchar(50) NOT NULL,
	user_password varchar(100) NOT NULL,
	password_salt varchar(100) NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
);

INSERT INTO expence_tracker.users (user_login, user_name, user_password, password_salt)
	VALUES ('Yettos', 'Piotr Cz', '12345', 'asdhvnm,,xcnvm,nasd');

CREATE TABLE expence_tracker.transactions (
	id_transaction SERIAL PRIMARY KEY,
	id_trans_ba integer REFERENCES expence_tracker.TRANSACTION_BANK_ACCOUNTS (ID_TRANS_BA),
	id_trans_cat integer REFERENCES expence_tracker.TRANSACTION_CATEGORY (ID_TRANS_CAT),
	id_trans_subcat integer REFERENCES expence_tracker.TRANSACTION_SUBCATEGORY (ID_TRANS_SUBCAT),
	id_trans_type integer REFERENCES expence_tracker.TRANSACTION_TYPE (ID_TRANS_TYPE),
	id_user integer REFERENCES expence_tracker.USERS (ID_USER),
	transaction_date date DEFAULT current_date,
	transaction_value dec(9, 2),
	transaction_description TEXT,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp
	);

INSERT INTO expence_tracker.transactions (id_trans_ba, id_trans_cat, id_trans_subcat, id_trans_type, id_user, transaction_value, transaction_description)
	VALUES (1, 1, 1, 1, 1, 234512, 'Groceries');
