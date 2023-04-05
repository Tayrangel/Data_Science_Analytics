SELECT *,
    CASE
        WHEN order_store = -100 THEN 'ECOMMERCE'
        ELSE 'Loja Física'
    END AS canal_venda
FROM pedidos 
LIMIT 5000