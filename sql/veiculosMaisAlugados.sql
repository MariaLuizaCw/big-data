WITH TiposVeiculosMaisAlugados AS (
    SELECT 
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria AS Tipo_Veiculo,
        COUNT(l.ID_Locacao) AS Quantidade_Locacoes
    FROM 
        Fato_Locacao l
    JOIN 
        Dim_Veiculo v ON l.ID_Veiculo = v.ID_Veiculo
    JOIN 
        Dim_Categoria c ON v.ID_Grupo = c.ID_Categoria
    JOIN 
        Dim_Cliente cl ON l.ID_Cliente = cl.ID_Cliente
    GROUP BY 
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria
),
LocacoesPorCidade AS (
    SELECT 
        SUBSTRING_INDEX(cl.Endereco, ',', 1) AS Cidade, -- Extrai a cidade do endereço
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria AS Tipo_Veiculo,
        COUNT(l.ID_Locacao) AS Quantidade_Locacoes
    FROM 
        Fato_Locacao l
    JOIN 
        Dim_Veiculo v ON l.ID_Veiculo = v.ID_Veiculo
    JOIN 
        Dim_Categoria c ON v.ID_Grupo = c.ID_Categoria
    JOIN 
        Dim_Cliente cl ON l.ID_Cliente = cl.ID_Cliente
    GROUP BY 
        Cidade,
        v.Marca,
        v.Modelo,
        v.Cor,
        v.Mecanizacao,
        v.Ar_Condicionado,
        v.Cadeirinha,
        c.Nome_Categoria
)
SELECT 
    'Global' AS Origem,
    Tipo_Veiculo,
    SUM(Quantidade_Locacoes) AS Quantidade_Locacoes
FROM 
    TiposVeiculosMaisAlugados
GROUP BY 
    Tipo_Veiculo

UNION ALL

SELECT 
    Cidade AS Origem,
    Tipo_Veiculo,
    SUM(Quantidade_Locacoes) AS Quantidade_Locacoes
FROM 
    LocacoesPorCidade
GROUP BY 
    Origem,
    Tipo_Veiculo
ORDER BY 
    Tipo_Veiculo,
    Origem;
