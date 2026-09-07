-- Удаление таблиц в правильном порядке (сначала зависимые)
DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS partners;

-- Создание таблицы партнёров
CREATE TABLE partners (
    partner_id      INTEGER PRIMARY KEY,
    company_name    VARCHAR(255) NOT NULL,
    inn             VARCHAR(20) NOT NULL UNIQUE,
    contact_email   VARCHAR(255),
    phone           VARCHAR(50),
    rating          NUMERIC(3, 1) CHECK (rating BETWEEN 0 AND 5)
);

-- Создание таблицы товаров
CREATE TABLE products (
    product_id      INTEGER PRIMARY KEY,
    product_name    VARCHAR(255) NOT NULL UNIQUE
);

-- Создание таблицы отгрузок (истории продаж)
CREATE TABLE shipments (
    sale_id         INTEGER PRIMARY KEY,
    partner_id      INTEGER NOT NULL REFERENCES partners (partner_id),
    product_id      INTEGER NOT NULL REFERENCES products (product_id),
    sale_date       DATE NOT NULL,
    quantity        INTEGER NOT NULL CHECK (quantity > 0),
    total_amount    NUMERIC(12, 2) NOT NULL CHECK (total_amount >= 0)
);
