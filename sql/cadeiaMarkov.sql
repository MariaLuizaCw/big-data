-- calcular o número de veículos retirados e devolvidos por pátio
WITH MovimentacaoVeiculos AS (
    SELECT 
        ID_Patio_Retirado,
        ID_Patio_Devolucao,
        COUNT(ID_Locacao) AS Quantidade
    FROM 
        Fato_Locacao
    GROUP BY 
        ID_Patio_Retirado,
        ID_Patio_Devolucao
),
-- calcular o total de veículos retirados por pátio
TotalVeiculosRetirados AS (
    SELECT 
        ID_Patio_Retirado,
        SUM(Quantidade) AS Total_Retirados
    FROM 
        MovimentacaoVeiculos
    GROUP BY 
        ID_Patio_Retirado
),
-- calcular a matriz estocástica de movimentação entre pátios
MatrizEstocastica AS (
    SELECT 
        r.ID_Patio_Retirado AS Pátio_Retirada,
        d.ID_Patio_Devolucao AS Pátio_Devolucao,
        IFNULL(mv.Quantidade / tr.Total_Retirados, 0) AS Percentual
    FROM 
        Dim_Patio r
    CROSS JOIN 
        Dim_Patio d
    LEFT JOIN 
        MovimentacaoVeiculos mv ON r.ID_Patio = mv.ID_Patio_Retirado AND d.ID_Patio = mv.ID_Patio_Devolucao
    LEFT JOIN 
        TotalVeiculosRetirados tr ON r.ID_Patio = tr.ID_Patio_Retirado
)
-- Consulta final para obter a matriz estocástica
SELECT 
    Pátio_Retirada,
    Pátio_Devolucao,
    Percentual
FROM 
    MatrizEstocastica
ORDER BY 
    Pátio_Retirada,
    Pátio_Devolucao;
