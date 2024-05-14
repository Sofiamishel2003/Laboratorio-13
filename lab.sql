-- Inciso c----------------------------------
-- Crear la tabla de dimensión de tiempo
CREATE TABLE bise1_sales.dim_tiempo AS
SELECT DISTINCT
    DATE_TRUNC('day', order_date) AS fecha,
    EXTRACT(DOW FROM order_date) AS dia_semana,
    EXTRACT(WEEK FROM order_date) AS semana_anio,
    EXTRACT(MONTH FROM order_date) AS mes,
    EXTRACT(QUARTER FROM order_date) AS trimestre,
    EXTRACT(YEAR FROM order_date) AS anio
FROM bise1_sales.fact_ordenes;

-- Crear índice en la tabla de dimensión de tiempo
CREATE INDEX idx_dim_tiempo_fecha ON bise1_sales.dim_tiempo (fecha);

-- Crear la tabla de dimensión de geografía
CREATE TABLE bise1_sales.dim_geografia AS
SELECT DISTINCT
    r.id AS region_id,
    r.name AS region_name,
    c.id AS country_id,
    c.name AS country_name,
    ct.id AS city_id,
    ct.name AS city_name
FROM bise1_sales.regions r
JOIN bise1_sales.countries c ON r.id = c.region_id
JOIN bise1_sales.cities ct ON c.iso_code::text = ct.country_iso_code;

-- Crear índices en la tabla de dimensión de geografía
CREATE INDEX idx_dim_geografia_region ON bise1_sales.dim_geografia (region_id);
CREATE INDEX idx_dim_geografia_country ON bise1_sales.dim_geografia (country_id);
CREATE INDEX idx_dim_geografia_city ON bise1_sales.dim_geografia (city_id);

-- Crear la tabla de dimensión de productos
CREATE TABLE bise1_sales.dim_productos AS
SELECT DISTINCT
    p.identifier AS product_id,
    p.name AS product_name,
    p.description AS product_description,
    c.id AS category_id,
    c.name AS category_name
FROM bise1_sales.products p
JOIN bise1_sales.categories c ON p.subcategory_reference = c.id;

-- Crear índices en la tabla de dimensión de productos
CREATE INDEX idx_dim_productos_product ON bise1_sales.dim_productos (product_id);
CREATE INDEX idx_dim_productos_category ON bise1_sales.dim_productos (category_id);

-- Crear la tabla de dimensión de canales
CREATE TABLE bise1_sales.dim_canales AS
SELECT DISTINCT
    id AS channel_id,
    class AS channel_class,
    name AS channel_name
FROM bise1_sales.channels;

-- Crear índice en la tabla de dimensión de canales
CREATE INDEX idx_dim_canales_channel ON bise1_sales.dim_canales (channel_id);

-- Crear la tabla de dimensión de promoción
CREATE TABLE bise1_sales.dim_promocion AS
SELECT DISTINCT
    p.id AS promotion_id,
    p.name AS promotion_name,
    p.description AS promotion_description,
    ps.id AS subcategory_id,
    ps.name AS subcategory_name,
    pc.id AS category_id,
    pc.name AS category_name
FROM bise1_sales.promotions p
JOIN bise1_sales.promo_subcategories ps ON p.subcategory_id = ps.id
JOIN bise1_sales.promo_categories pc ON ps.category_id = pc.id;

-- Crear índice en la tabla de dimensión de promoción
CREATE INDEX idx_dim_promocion_promotion ON bise1_sales.dim_promocion (promotion_id);
CREATE INDEX idx_dim_promocion_subcategory ON bise1_sales.dim_promocion (subcategory_id);
CREATE INDEX idx_dim_promocion_category ON bise1_sales.dim_promocion (category_id);

