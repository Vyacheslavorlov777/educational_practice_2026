-- ETL: Extract -> Transform -> Load
-- Extract: исходные данные взяты из import_partners.csv и import_sales.txt
-- Transform: очистка выполнена вручную, результат в cleaned_partners.csv и cleaned_sales.csv
--   - убраны лишние пробелы в названиях компаний
--   - дата 15.03.2026 приведена к формату 2026-03-15
--   - продажа sale_id=104 (partner_id=4) исключена: такого партнёра нет в partners
-- Load: загрузка очищенных данных в таблицы

-- Загрузка партнёров
INSERT INTO partners (partner_id, company_name, inn, contact_email, phone, rating)
VALUES
    (1, 'ООО "Логистик-Экспресс"', '7701234567', 'info@logex.ru', '+7 (999) 111-22-33', 4.8),
    (2, 'ИП Петров И.И.', '5001098765', 'petrov_delivery@mail.ru', NULL, 4.2),
    (3, 'ТД "Быстрый путь"', '7812345678', 'speedway@yandex.ru', '+78125554433', NULL);

-- Загрузка товаров (уникальные названия из продаж)
INSERT INTO products (product_id, product_name)
VALUES
    (1, 'Стиральный порошок "Альфа"'),
    (2, 'Мыло жидкое "Стандарт"'),
    (3, 'Кондиционер для белья');

-- Загрузка отгрузок
-- sale_id=104 (partner_id=4) не загружается: партнёр отсутствует в partners,
-- загрузка нарушила бы FOREIGN KEY
INSERT INTO shipments (sale_id, partner_id, product_id, sale_date, quantity, total_amount)
VALUES
    (101, 1, 1, '2026-03-01', 50, 25000.00),
    (102, 2, 2, '2026-03-15', 200, 18000.50),
    (103, 1, 3, '2026-03-20', 30, 10500.00),
    (105, 3, 2, '2026-03-25', 150, 13500.00);
