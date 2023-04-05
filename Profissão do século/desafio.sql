SELECT
    CASE 
        WHEN payment_method_raw LIKE '%CARTÃO%' THEN 'Cartão'
        WHEN payment_method_raw LIKE '%BOLETO%' THEN 'Boleto'
        WHEN payment_method_raw LIKE '%TED%' THEN 'Ted ou Dinheiro'
        WHEN payment_method_raw LIKE '%DINHEIRO%' THEN 'Ted ou Dinheiro'
        WHEN payment_method_raw LIKE '%PAYPAL%' THEN 'Paypal'
        WHEN payment_method_raw LIKE '%NULL%' THEN 'Sem informação de forma de pagamento'
        ELSE 'Outros'
    END AS formas_pagamento,
    SUM(price * quantity) AS valor_total
FROM pedidos 
    INNER JOIN  pedidositens on pedidos.order_id = pedidositens.order_id
GROUP BY formas_pagamento
ORDER BY valor_total DESC