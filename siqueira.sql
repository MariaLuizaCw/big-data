-- Tabela de Clientes
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    CNH VARCHAR(20) NOT NULL,
    ExpiracaoCNH DATE NOT NULL,
    CPF_CNPJ VARCHAR(20) NOT NULL,
    PessoaFisica BOOLEAN NOT NULL,
    Endereco TEXT,
    Telefone VARCHAR(15),
    Email VARCHAR(255),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Veículos
CREATE TABLE Veiculo (
    ID INT PRIMARY KEY,
    Placa VARCHAR(10) NOT NULL,
    Chassis VARCHAR(50) NOT NULL,
    Grupo VARCHAR(50),
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    Cor VARCHAR(20),
    ArCondicionado BOOLEAN,
    MecanizacaoAutomatica BOOLEAN,
    Cadeirinha BOOLEAN,
    Largura INT,
    Comprimento INT,
    Foto VARCHAR(255),
    Prontuario TEXT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Reservas
CREATE TABLE Reservas (
    ID INT PRIMARY KEY,
    ClienteId INT,
    VeiculoId INT,
    PatioId INT,
    DataReserva DATE,
    DataPrevistaRetirada DATE,
    DataPrevistaDevolucao DATE,
    CarroRetirado BOOLEAN,
    ValorReserva DECIMAL(10, 2),
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(ID),
    FOREIGN KEY (VeiculoId) REFERENCES Veiculo(ID),
    FOREIGN KEY (PatioId) REFERENCES Patio(ID)
);

-- Tabela de Locações
CREATE TABLE Locacao (
    ID INT PRIMARY KEY,
    ClienteId INT,
    VeiculoId INT,
    PatioRetiradoId INT,
    PatioDevolucaoId INT,
    DataRetirada DATE,
    DataDevolucao DATE,
    Devolvido BOOLEAN,
    Protecoes_Adicionais TEXT,
    EstadoEntrega TEXT,
    EstadoDevolucao TEXT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ClienteId) REFERENCES Clientes(ID),
    FOREIGN KEY (VeiculoId) REFERENCES Veiculo(ID),
    FOREIGN KEY (PatioRetiradoId) REFERENCES Patio(ID),
    FOREIGN KEY (PatioDevolucaoId) REFERENCES Patio(ID)
);

-- Tabela de Pátios
CREATE TABLE Patio (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Localizacao TEXT,
    Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);