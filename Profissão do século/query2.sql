SELECT 
    status, 
    SUM(valor_do_orcamento) as total_orcado
FROM forcamentos 
GROUP BY status
ORDER BY total_orcado DESC