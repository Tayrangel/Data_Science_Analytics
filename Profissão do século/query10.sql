WITH TabelaTeste AS (
    SELECT *,
        CASE
            WHEN order_store = -100 THEN 'ECOMMERCE'
            ELSE 'Loja Física'
        END AS canal_venda
    FROM pedidos
) 
SELECT 
    canal_venda,
    SUM(price * quantity) AS total_venda
FROM TabelaTeste
    JOIN pedidositens ON TabelaTeste.order_id = pedidositens.order_id
GROUP BY canal_venda