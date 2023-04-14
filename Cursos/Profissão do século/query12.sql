SELECT DISTINCT -- SELECIONA DISTINTOS
    A.order_date,
    valor_total, --CRIADO NO JOIN
    SUM(price * quantity)
        -- CRIAÇÃO DO WINDOW FUNCTION PARA CRIAR O VALOR ACUMULADO COM A ORDEM DO MENOR PARA O MAIOR
        OVER(
            ORDER BY A.order_date ASC
        ) AS valor_acumulado
FROM pedidositens A -- NOMEOU A TABELA PEDIDOSITENS PARA A
    JOIN (
        SELECT
            order_date,
            SUM(price * quantity) AS valor_total --CRIAÇÃO DO VALOR_TOTAL
        FROM pedidositens
        GROUP BY order_date
        ORDER BY order_date
    ) B ON A.order_date = B.order_date
ORDER BY A.order_date