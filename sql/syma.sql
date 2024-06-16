CREATE TABLE Grupo_Categoria (
    ID_Grupo SERIAL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Faixa_Valor_Diaria DECIMAL(10, 2) NOT NULL
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    ID_Veiculo SERIAL PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Cor VARCHAR(20) NOT NULL,
    Grupo_Categoria INT REFERENCES Grupo_Categoria(ID_Grupo),
    Ar_Condicionado BOOLEAN NOT NULL,
    Dimensoes VARCHAR(100),
    Foto_URL VARCHAR(255)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ID_Cliente SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo VARCHAR(20) CHECK (Tipo IN ('Pessoa Física', 'Pessoa Jurídica')),
    CPF_CNPJ VARCHAR(20),
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Numero_CNH VARCHAR(20),
    Validade_CNH DATE
);

-- Tabela Reserva
CREATE TABLE Reserva (
    ID_Reserva SERIAL PRIMARY KEY,
    ID_Cliente INT REFERENCES Cliente(ID_Cliente),
    ID_Veiculo INT REFERENCES Veiculo(ID_Veiculo),
    Data_Reserva DATE NOT NULL,
    Data_Retirada DATE NOT NULL,
    Data_Devolucao DATE NOT NULL,
    Estado VARCHAR(20) CHECK (Estado IN ('Pendente', 'Confirmada', 'Cancelada'))
);

-- Tabela Locacao
CREATE TABLE Locacao (
    ID_Locacao SERIAL PRIMARY KEY,
    ID_Reserva INT REFERENCES Reserva(ID_Reserva),
    Data_Retirada DATE NOT NULL,
    Data_Devolucao DATE NOT NULL,
    Patio_Saida INT REFERENCES Patio(ID_Patio),
    Patio_Chegada INT REFERENCES Patio(ID_Patio),
    Valor_Total DECIMAL(10, 2) NOT NULL
);

-- Tabela Patio
CREATE TABLE Patio (
    ID_Patio SERIAL PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Endereco VARCHAR(255) NOT NULL
);