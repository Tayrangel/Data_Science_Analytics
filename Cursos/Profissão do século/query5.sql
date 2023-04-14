SELECT 
    cliente, 
    SUM(valor_do_orcamento) as total_orcado
FROM forcamentos
--WHERE status = "VENDIDO"
--WHERE status IN ('VENDIDO', 'EM NEGOCIAÇÃO')
--WHERE status = 'VENDIDO' OR status = 'EM NEGOCIAÇÃO' --EXATAMENTE O MESMO FILTRO DA LINHA ANTERIOR
--WHERE NOT setor_cliente = 'BANCOS'
--WHERE status = 'VENDIDO' AND setor_cliente = 'BANCOS'
--WHERE status = 'VENDIDO' AND data_cotacao BETWEEN '2020-07-01' AND '2020-07-31'
WHERE cliente LIKE '%Energia%' --SÍMBOLO DE % AUXÍLIA O FILTRO, SE FOR PROCURAR A PALAVRA SOMENTE NO COMEÇO ADICIONE A % NO FIM, E SE FOR NO FINAL O INVERSO 
GROUP BY cliente
ORDER BY total_orcado DESC