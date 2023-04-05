--SELECT *,
--    LEAD(order_date)
--    OVER(
--        PARTITION BY customer_id
--        ORDER BY order_date ASC
--    ) AS proxima_data_pedido
--FROM pedidos

SELECT *,
    LAG(order_date)
    OVER(
        PARTITION BY customer_id
        ORDER BY order_date ASC
    ) AS proxima_data_pedido
FROM pedidos
