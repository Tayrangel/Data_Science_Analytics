SELECT *, 'ECOMMERCE' AS canal_venda
FROM pedidos 
WHERE order_store = -100
UNION ALL
SELECT *, 'LOJA FÍSICA' AS canal_venda
FROM pedidos
WHERE order_store <> -100