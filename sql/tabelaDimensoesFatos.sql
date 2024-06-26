-- INTEGRANTES DO GRUPO --
--Igor Telles - 120040283
--Sylvio Mello - 119093388
--Maria Luiza C. Wuillaume - 120040005
--Felipe Vilela - 119093087 
--

-- Dimensão Cliente
CREATE TABLE Dim_Cliente (
    ID_Cliente INT PRIMARY KEY,
    ID_Cliente_Syma INT,
    ID_Cliente_Rayssa INT,
    ID_Cliente_Antonny INT,
    ID_Cliente_Siqueira INT,
    Nome VARCHAR(255) NOT NULL,
    Tipo_Cliente VARCHAR(20),
    Documento VARCHAR(20) NOT NULL,
    Endereco TEXT,
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    CNH VARCHAR(20),
    Data_Validade_CNH DATE,
    Data_Nascimento DATE,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dimensão Veículo
CREATE TABLE Dim_Veiculo (
    ID_Veiculo INT PRIMARY KEY,
    ID_Veiculo_Syma INT,
    ID_Veiculo_Rayssa INT,
    ID_Veiculo_Antonny INT,
    ID_Veiculo_Siqueira INT,
    Placa VARCHAR(10) NOT NULL,
    Chassis VARCHAR(50),
    ID_Grupo INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Cor VARCHAR(20),
    Ar_Condicionado BOOLEAN,
    Mecanizacao VARCHAR(20),
    Cadeirinha BOOLEAN,
    Dimensoes, VARCHAR(50),
    Foto VARCHAR(255),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dimensão Categoria
CREATE TABLE Dim_Categoria (
    ID_Categoria INT PRIMARY KEY,
    ID_Categoria_Syma INT,
    ID_Categoria_Rayssa INT,
    ID_Categoria_Antonny INT,
    ID_Categoria_Siqueira INT,
    Nome_Categoria VARCHAR(50),
    Valor_por_Dia DECIMAL(10, 2)
);

-- Dimensão Pátio
CREATE TABLE Dim_Patio (
    ID_Patio INT PRIMARY KEY,
    ID_Patio_Syma INT,
    ID_Patio_Rayssa INT, 
    ID_Patio_Antonny INT, 
    ID_Patio_Siqueira INT, 
    Nome VARCHAR(50),
    Localizacao TEXT,
    Capacidade INT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Fato Reserva
CREATE TABLE Fato_Reserva (
    ID_Reserva INT PRIMARY KEY,
    ID_Reserva_Syma INT,
    ID_Reserva_Rayssa INT,
    ID_Reserva_Antonny INT,
    ID_Reserva_Siqueira INT,
    ID_Cliente INT,
    ID_Veiculo INT,
    ID_Patio INT,
    Data_Reserva DATE,
    Data_Prevista_Retirada DATE,
    Data_Prevista_Devolucao DATE,
    Valor_Reserva DECIMAL(10, 2),
    Status_Reserva VARCHAR(20),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Veiculo) REFERENCES Dim_Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Patio) REFERENCES Dim_Patio(ID_Patio)
);

-- Fato Locação
CREATE TABLE Fato_Locacao (
    ID_Locacao INT PRIMARY KEY,
    ID_Locacao_Syma INT,
    ID_Locacao_Rayssa INT,
    ID_Locacao_Antonny INT,
    ID_Locacao_Siqueira INT,
    ID_Reserva INT,
    ID_Cliente INT,
    ID_Veiculo INT,
    ID_Patio_Retirado INT,
    ID_Patio_Devolucao INT,
    Data_Retirada DATE,
    Data_Devolucao_Realizada DATE,
    Valor_Locacao DECIMAL(10, 2),
    Protecoes_Adicionais TEXT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Reserva) REFERENCES Fato_Reserva(ID_Reserva),
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Veiculo) REFERENCES Dim_Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Patio_Retirado) REFERENCES Dim_Patio(ID_Patio),
    FOREIGN KEY (ID_Patio_Devolucao) REFERENCES Dim_Patio(ID_Patio)
);