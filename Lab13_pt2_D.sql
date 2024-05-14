SELECT 
    fo.channel,
    fo.order_date,
    fo.amount,
    fo.quantity,
    fo.cost,
    fo.customer_id,
    cu.name AS customer_name,
    fo.promotion_id,
    pr.name AS promotion_name,
    fo.product_id,
    p.name AS product_name,
    c.name AS channel_name
FROM 
    bise1_sales.fact_ordenes AS fo
JOIN 
    bise1_sales.customers AS cu ON fo.customer_id = cu.id
JOIN 
    bise1_sales.promotions AS pr ON fo.promotion_id = pr.id
JOIN 
    bise1_sales.products AS p ON fo.product_id = p.identifier
JOIN 
    bise1_sales.channels AS c ON fo.channel = c.name;
