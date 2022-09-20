-- patients table
CREATE TABLE patients
(
    id            INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    name          VARCHAR(50)                      NOT NULL,
    date_of_birth DATE
);

-- medical histories table
CREATE TABLE medical_histories
(
    id          INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP                        NOT NULL,
    patient_id  INT                              NOT NULL,
    status      VARCHAR(20)                      NOT NULL
);

-- treatments table
CREATE TABLE treatments
(
    id   INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    type VARCHAR(50)                      NOT NULL,
    name VARCHAR(50)                      NOT NULL
);

-- invoices table
CREATE TABLE invoices
(
    id                 INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    total_amount       DECIMAL(10, 2)                   NOT NULL,
    generated_at       TIMESTAMP                        NOT NULL,
    payed_at           TIMESTAMP,
    medical_history_id INT
);

-- invoice_items table
CREATE TABLE invoices_items(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY NOT NULL,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT
)


