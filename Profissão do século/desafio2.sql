WITH PedidosCanal AS (
    SELECT *,
        CASE
            WHEN order_store = -100 THEN 'ECOMMERCE'
            ELSE ''
        END AS canal_venda
    FROM pedidos
) 
SELECT 
    A.canal_venda,
    SUM(B.price * B.quantity) AS total_venda,
    COUNT(DISTINCT B.order_id) AS qtd_pedidos
FROM PedidosCanal A
    JOIN pedidositens B ON A.order_id = B.order_id
GROUP BY canal_venda