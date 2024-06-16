SELECT 
    v.Marca,
    v.Modelo,
    v.Cor,
    v.Mecanizacao,
    v.Ar_Condicionado,
    v.Cadeirinha,
    c.Nome_Categoria,
    COUNT(v.ID_Veiculo) AS Quantidade
FROM 
    Dim_Veiculo v
JOIN 
    Dim_Categoria c ON v.ID_Grupo = c.ID_Categoria
JOIN 
    Fato_Reserva r ON v.ID_Veiculo = r.ID_Veiculo
JOIN
    Dim_Patio p ON r.ID_Patio = p.ID_Patio
WHERE 
    r.Status_Reserva = 'No Pátio' AND p.Nome = 'Nome Pátio'
GROUP BY 
    v.Marca, 
    v.Modelo, 
    v.Cor, 
    v.Mecanizacao, 
    v.Ar_Condicionado, 
    v.Cadeirinha, 
    c.Nome_Categoria;
