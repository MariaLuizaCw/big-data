WITH ReservasPorTipoPatio AS (
    SELECT 
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria,
        p.Nome AS Nome_Patio,
        'Próxima Semana' AS Periodo,
        COUNT(r.ID_Reserva) AS Quantidade_Reservas
    FROM 
        Fato_Reserva r
    JOIN 
        Dim_Veiculo v ON r.ID_Veiculo = v.ID_Veiculo
    JOIN 
        Dim_Categoria c ON v.ID_Grupo = c.ID_Categoria
    JOIN 
        Dim_Patio p ON r.ID_Patio = p.ID_Patio
    JOIN 
        Dim_Cliente cl ON r.ID_Cliente = cl.ID_Cliente
    WHERE 
        r.Data_Prevista_Retirada BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) -- Escolha do tempo, ex: 1 semana
    GROUP BY 
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria,
        p.Nome
),
ReservasPorEndereco AS (
    SELECT 
        SUBSTRING_INDEX(cl.Endereco, ',', 1) AS Cidade, -- Extrai a cidade do endereço
        'Próxima Semana' AS Periodo,
        COUNT(r.ID_Reserva) AS Quantidade_Reservas
    FROM 
        Fato_Reserva r
    JOIN 
        Dim_Cliente cl ON r.ID_Cliente = cl.ID_Cliente
    WHERE 
        r.Data_Prevista_Retirada BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
    GROUP BY 
        Cidade
)
SELECT * FROM ReservasPorTipoPatio
UNION ALL
SELECT * FROM ReservasPorEndereco;
