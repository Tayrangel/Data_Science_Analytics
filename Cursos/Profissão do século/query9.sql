SELECT
    A.canal_venda,
    SUM(B.price * B.quantity) AS total_venda
FROM (
    SELECT *,
        CASE
            WHEN order_store = -100 THEN 'ECOMMERCE'
            ELSE 'Loja Física'
        END AS canal_venda
    FROM pedidos
) A
    JOIN pedidositens B ON A.order_id = B.order_id
GROUP BY canal_venda