SELECT 
    status, 
    SUM(valor_do_orcamento) as total_orcado,
    AVG(valor_do_orcamento) as media_orcado,
    COUNT(*) as qtd_orcamentos
FROM forcamentos 
GROUP BY status
ORDER BY total_orcado DESC