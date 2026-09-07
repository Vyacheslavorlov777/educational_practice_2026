-- Запрос №1: список партнёров (для просмотра в приложении)
SELECT
    partner_id,
    company_name,
    inn,
    contact_email,
    phone,
    rating
FROM partners
ORDER BY partner_id;

-- Запрос №2: редактирование данных партнёра
-- Пример: обновляем телефон и рейтинг партнёра с partner_id = 2
UPDATE partners
SET
    phone = '+7 (999) 222-33-44',
    rating = 4.5
WHERE partner_id = 2;

-- Запрос №3: история отгрузок конкретного партнёра
-- Пример параметра: partner_id = 1
SELECT
    p.partner_id,
    p.company_name,
    pr.product_name,
    s.sale_date,
    s.quantity,
    s.total_amount
FROM shipments s
JOIN partners p ON p.partner_id = s.partner_id
JOIN products pr ON pr.product_id = s.product_id
WHERE s.partner_id = 1
ORDER BY s.sale_date;
