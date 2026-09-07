-- Запрос №1: список партнёров с количеством доставок
-- Сортировка по названию, LEFT JOIN + COUNT, чтобы партнёры без доставок тоже попали в список
SELECT
    p.partner_id,
    p.company_name,
    p.inn,
    p.contact_email,
    p.phone,
    p.rating,
    COUNT(s.sale_id) AS total_shipments
FROM partners p
LEFT JOIN shipments s ON s.partner_id = p.partner_id
GROUP BY p.partner_id, p.company_name, p.inn, p.contact_email, p.phone, p.rating
ORDER BY p.company_name;

-- Запрос №2: добавление нового партнёра и его первой тестовой доставки (транзакция)
-- Пример: новый партнёр partner_id = 4, первая доставка товара product_id = 1
BEGIN;

INSERT INTO partners (partner_id, company_name, inn, contact_email, phone, rating)
VALUES (4, 'ООО "Новый партнёр"', '7799887766', 'new@partner.ru', '+7 (999) 000-00-00', NULL);

INSERT INTO shipments (sale_id, partner_id, product_id, sale_date, quantity, total_amount)
VALUES (106, 4, 1, CURRENT_DATE, 1, 500.00);

COMMIT;

-- Запрос №3: история отгрузок партнёра за период
-- Пример параметров: partner_id = 1, период с 2026-03-01 по 2026-03-31
SELECT
    p.company_name,
    pr.product_name,
    s.sale_date,
    s.quantity,
    s.total_amount
FROM shipments s
JOIN partners p ON p.partner_id = s.partner_id
JOIN products pr ON pr.product_id = s.product_id
WHERE s.partner_id = 1
    AND s.sale_date BETWEEN '2026-03-01' AND '2026-03-31'
ORDER BY s.sale_date;
