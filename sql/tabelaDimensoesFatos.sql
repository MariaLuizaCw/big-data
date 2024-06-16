-- Dimensão Cliente
CREATE TABLE Dim_Cliente (
    ID_Cliente INT PRIMARY KEY,
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
    Placa VARCHAR(10) NOT NULL,
    Chassis VARCHAR(50),
    ID_Grupo INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Cor VARCHAR(20),
    Ar_Condicionado BOOLEAN,
    Mecanizacao VARCHAR(20),
    Cadeirinha BOOLEAN,
    Largura INT,
    Comprimento INT,
    Foto VARCHAR(255),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Dimensão Categoria
CREATE TABLE Dim_Categoria (
    ID_Categoria INT PRIMARY KEY,
    Nome_Categoria VARCHAR(50),
    Valor_por_Dia DECIMAL(10, 2)
);

-- Dimensão Pátio
CREATE TABLE Dim_Patio (
    ID_Patio INT PRIMARY KEY,
    Nome VARCHAR(50),
    Localizacao TEXT,
    Capacidade INT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Fato Reserva
CREATE TABLE Fato_Reserva (
    ID_Reserva INT PRIMARY KEY,
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
    ID_Reserva INT,
    ID_Cliente INT,
    ID_Veiculo INT,
    ID_Patio_Retirado INT,
    ID_Patio_Devolucao INT,
    Data_Retirada DATE,
    Data_Devolucao_Prevista DATE,
    Data_Devolucao_Realizada DATE,
    Valor_Locacao DECIMAL(10, 2),
    Protecoes_Adicionais TEXT,
    Estado_Entrega TEXT,
    Estado_Devolucao TEXT,
    Status_Locacao VARCHAR(20),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ID_Reserva) REFERENCES Fato_Reserva(ID_Reserva),
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Veiculo) REFERENCES Dim_Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Patio_Retirado) REFERENCES Dim_Patio(ID_Patio),
    FOREIGN KEY (ID_Patio_Devolucao) REFERENCES Dim_Patio(ID_Patio)
);