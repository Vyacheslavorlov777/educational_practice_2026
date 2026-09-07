# Задание 2. Написание DDL-скрипта

## Что делает schema.sql

Скрипт полностью создаёт структуру базы данных с нуля. Перед созданием
таблиц он удаляет их (`DROP TABLE IF EXISTS`) в правильном порядке —
сначала `shipments` (зависит от других таблиц), потом `products` и
`partners`. Это делает скрипт безопасным для повторного запуска.

## Какие таблицы создаются

* `partners` — партнёры (PK `partner_id`, уникальный `inn`).
* `products` — товары (PK `product_id`, уникальное `product_name`).
* `shipments` — отгрузки (PK `sale_id`, FK на `partners` и `products`).

## Какие связи создаются

* `shipments.partner_id` → `partners.partner_id`
* `shipments.product_id` → `products.product_id`

## Ограничения

* `NOT NULL` на обязательных полях.
* `UNIQUE` на `inn` и `product_name`, чтобы избежать дублей.
* `CHECK` на `rating` (0–5), `quantity` (> 0) и `total_amount` (>= 0) для
  защиты от некорректных значений.

## Как запустить скрипт

```bash
psql -U postgres -d your_database -f schema.sql
```
