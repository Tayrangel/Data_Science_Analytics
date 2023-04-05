-- SELECT *,
--    ROW_NUMBER()
--    OVER (
--        ORDER BY nota
--    ) AS ranking
-- FROM notas

-- SELECT *,
--    RANK()
--    OVER (
--        ORDER BY nota
--    ) AS ranking
-- FROM notas

-- SELECT *,
--    DENSE_RANK()
--    OVER (
--        ORDER BY nota
--    ) AS ranking
-- FROM notas

--SELECT *,
--    DENSE_RANK()
--    OVER (
--        PARTITION BY materia
--        ORDER BY nota
--   ) AS ranking
--FROM notas

SELECT *,
    NTILE(4) -- QUANDO FAZEMOS 100% / 4, ENTÃO TERÁ A DIVISÃO DO PERCENTIL
    OVER(
       ORDER BY nota DESC
    ) AS percentil
FROM notas
-- PERCENTIL 1: 75% - 100%, PERCENTIL 2: 75% - 50%, PERCENTIL 3: 50% - 25%, PERCENTIL 4: 25% - 0%