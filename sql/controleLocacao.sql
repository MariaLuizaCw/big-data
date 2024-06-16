SELECT 
    v.Marca,
    v.Modelo,
    v.Cor,
    v.Mecanizacao,
    v.Ar_Condicionado,
    v.Cadeirinha,
    c.Nome_Categoria,
    l.Data_Retirada,
    l.Data_Devolucao_Realizada,
    DATEDIFF(CURDATE(), l.Data_Retirada) AS Tempo_Locacao,
    DATEDIFF(l.Data_Devolucao_Realizada, CURDATE()) AS Tempo_Restante_Devolucao
FROM 
    Dim_Veiculo v
JOIN 
    Dim_Categoria c ON v.ID_Grupo = c.ID_Categoria
JOIN 
    Fato_Locacao l ON v.ID_Veiculo = l.ID_Veiculo
JOIN
    Fato_Reserva r ON l.ID_Reserva = r.ID_Reserva
WHERE 
    l.Data_Devolucao_Realizada IS NULL
ORDER BY 
    Tempo_Restante_Devolucao ASC;
