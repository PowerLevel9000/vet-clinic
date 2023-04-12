------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--**************************************************************** week-2 DAY 2 table creation Based on diagram ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
CREATE TABLE patients (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_history (
    id INT NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(100),
    CONSTRAINT "patient_id_foreign" FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE INDEX ON medical_histories (patient_id);

CREATE TABLE treatment (
    id INT NOT NULL PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100),
    CONSTRAINT "medical_history_id_foreign" FOREIGN KEY (id) REFERENCES medical_history(id)
);

ALTER TABLE
    medical_history
ADD
    CONSTRAINT "many_many_id" FOREIGN KEY (id) REFERENCES treatment(id);

CREATE TABLE medical_history_treatment (
    medical_history_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (medical_history_id, treatment_id),
    FOREIGN KEY (medical_history_id) REFERENCES medical_history(id),
    FOREIGN KEY (treatment_id) REFERENCES treatment(id)
);

\ d patients;

--                          Table "public.patients"
--     Column     |          Type          | Collation | Nullable | Default
-- ---------------+------------------------+-----------+----------+---------
--  id            | integer                |           | not null |
--  name          | character varying(100) |           |          |
--  date_of_birth | date                   |           | not null |
-- Indexes:
--     "patients_pkey" PRIMARY KEY, btree (id)
-- Referenced by:
--     TABLE "medical_history" CONSTRAINT "patient_id_foreign" FOREIGN KEY (patient_id) REFERENCES patients(id)
\ d medical_history;

--                        Table "public.medical_history"
--    Column    |            Type             | Collation | Nullable | Default
-- -------------+-----------------------------+-----------+----------+---------
--  id          | integer                     |           | not null |
--  admitted_at | timestamp without time zone |           | not null |
--  patient_id  | integer                     |           | not null |
--  status      | character varying(100)      |           |          |
-- Indexes:
--     "medical_history_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "many_many_id" FOREIGN KEY (id) REFERENCES treatment(id)
--     "patient_id_foreign" FOREIGN KEY (patient_id) REFERENCES patients(id)
-- Referenced by:
--     TABLE "treatment" CONSTRAINT "medical_history_id_foreign" FOREIGN KEY (id) REFERENCES medical_history(id)
--     TABLE "medical_history_treatment" CONSTRAINT "medical_history_treatment_medical_history_id_fkey" FOREIGN KEY (medical_history_id) REFERENCES medical_history(id)
\ d medical_history_treatment;

--            Table "public.medical_history_treatment"
--        Column       |  Type   | Collation | Nullable | Default
-- --------------------+---------+-----------+----------+---------
--  medical_history_id | integer |           | not null |
--  treatment_id       | integer |           | not null |
-- Indexes:
--     "medical_history_treatment_pkey" PRIMARY KEY, btree (medical_history_id, treatment_id)
-- Foreign-key constraints:
--     "medical_history_treatment_medical_history_id_fkey" FOREIGN KEY (medical_history_id) REFERENCES medical_history(id)
--     "medical_history_treatment_treatment_id_fkey" FOREIGN KEY (treatment_id) REFERENCES treatment(id)
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
/********************************************************************** Rita contribution **************************************************************************/
CREATE TABLE invoices (
    id INT NOT NULL PRIMARY KEY,
    total_amount decimal NOT NULL,
    generated_at timestamp NOT NULL,
    payed_at timestamp NOT NULL,
    medical_histories_id INT NOT NULL
);
-- CREATE TABLE
CREATE INDEX ON invoices (medical_histories_id);
-- CREATE INDEX
CREATE TABLE invoice_items (
    id INT NOT NULL PRIMARY KEY,
    unit_price decimal NOT NULL,
    quantity INT NOT NULL,
    total_price decimal NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    CONSTRAINT "treatment_id_foreign" FOREIGN KEY (treatment_id) REFERENCES treatment(id)
);
-- CREATE TABLE

\d invoices;
--                                Table "public.invoices"
--         Column        |            Type             | Collation | Nullable | Default
-- ----------------------+-----------------------------+-----------+----------+---------
--  id                   | integer                     |           | not null |
--  total_amount         | numeric                     |           | not null |
--  generated_at         | timestamp without time zone |           | not null |
--  payed_at             | timestamp without time zone |           | not null |
--  medical_histories_id | integer                     |           | not null |
-- Indexes:
--     "invoices_pkey" PRIMARY KEY, btree (id)
--     "invoices_medical_histories_id_idx" btree (medical_histories_id)
-- Referenced by:
--     TABLE "invoice_items" CONSTRAINT "invoice_items_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES invoices(id)
\d invoice_items;
--               Table "public.invoice_items"
--     Column    |  Type   | Collation | Nullable | Default
-- --------------+---------+-----------+----------+---------
--  id           | integer |           | not null |
--  unit_price   | numeric |           | not null |
--  quantity     | integer |           | not null |
--  total_price  | numeric |           | not null |
--  invoice_id   | integer |           | not null |
--  treatment_id | integer |           | not null |
-- Indexes:
--     "invoice_items_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "invoice_items_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES invoices(id)
--     "treatment_id_foreign" FOREIGN KEY (treatment_id) REFERENCES treatment(id)