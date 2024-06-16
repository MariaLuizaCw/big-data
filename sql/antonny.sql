-- Tabela Clientes
CREATE TABLE Clientes (
ID_Cliente INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Nome VARCHAR(90) NOT NULL,
Tipo_Cliente ENUM('Fisica', 'Juridica') NOT NULL,
Documento VARCHAR(14) NOT NULL,
ID_Endereco INT NOT NULL,
Telefone INT NOT NULL,
Email VARCHAR(45) NOT NULL,
Data_Nascimento DATE NOT NULL,
CNH INT NULL,
Data_Validade_CNH DATE NULL,
CNPJ_Empresa VARCHAR(14) NULL,
FOREIGN KEY (ID_Endereco) REFERENCES Endereco(ID_Endereco)
);
-- Tabela Veículos
CREATE TABLE Veículos (
ID_Veículo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_Grupo INT NOT NULL,
Placa VARCHAR(10) NOT NULL,
Marca VARCHAR(45) NOT NULL,
Modelo VARCHAR(45) NOT NULL,
Cor VARCHAR(45) NOT NULL,
Ar_Condicionado BIT NOT NULL,
Mecanização ENUM('Manual', 'Automática') NOT NULL,
Cadeirinha BIT NOT NULL,
Link_Fotos VARCHAR(255) NOT NULL,
Assentos INT NOT NULL,
Tamanho_Mala FLOAT NOT NULL,
Carga_Maxima FLOAT NOT NULL,
FOREIGN KEY (ID_Grupo) REFERENCES Grupos_Veículos(ID_Grupo)
);
-- Tabela Grupos Veículos
CREATE TABLE Grupos_Veículos (
ID_Grupo INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Nome_Grupo VARCHAR(45) NOT NULL
);
-- Tabela Prontuário
CREATE TABLE Prontuário (
ID_Prontuário INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_Veículo INT NOT NULL,
Data_Registro DATE NOT NULL,
Descrição_Manutenção VARCHAR(255) NOT NULL,
Estado_Conservação ENUM('1', '2', '3', '4', '5') NOT NULL,
Pressão_Pneus FLOAT NOT NULL,
Nível_Óleo BIT NOT NULL,
FOREIGN KEY (ID_Veículo) REFERENCES Veículos(ID_Veículo)
);
-- Tabela Pátios
CREATE TABLE Pátios (
ID_Pátio INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_Endereco INT NOT NULL,
Capacidade INT NOT NULL,
FOREIGN KEY (ID_Endereco) REFERENCES Endereco(ID_Endereco)
);
-- Tabela Reservas
CREATE TABLE Reservas (
ID_Reserva INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_Cliente INT NOT NULL,
ID_Veículo INT NOT NULL,
Data_Reserva DATE NOT NULL,
Data_Início DATE NOT NULL,
Data_Fim DATE NOT NULL,
Status_Reserva ENUM('Ativa', 'Cancelada', 'Concluída') NOT NULL,
Pátio_Retirada INT NOT NULL,
Pátio_Devolução INT NOT NULL,
FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
FOREIGN KEY (ID_Veículo) REFERENCES Veículos(ID_Veículo),
FOREIGN KEY (Pátio_Retirada) REFERENCES Pátios(ID_Pátio),
FOREIGN KEY (Pátio_Devolução) REFERENCES Pátios(ID_Pátio)
);
-- Tabela Locações
CREATE TABLE Locações (
ID_Locação INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
ID_Reserva INT NOT NULL,
Data_Retirada DATE NOT NULL,
Data_Devolução_Prevista DATE NOT NULL,
Data_Devolução_Realizada DATE NOT NULL,
Valor_Aluguel FLOAT NOT NULL,
Pátio_Retirada INT NOT NULL,
Pátio_Devolução INT NOT NULL,
Status_Locação ENUM('Em andamento', 'Concluída', 'Cancelada') NOT NULL,
FOREIGN KEY (ID_Reserva) REFERENCES Reservas(ID_Reserva),
FOREIGN KEY (Pátio_Retirada) REFERENCES Pátios(ID_Pátio),
FOREIGN KEY (Pátio_Devolução) REFERENCES Pátios(ID_Pátio)
);
-- Tabela Endereço
CREATE TABLE Endereco (
ID_Endereco INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Rua VARCHAR(90) NOT NULL,
Numero INT NOT NULL,
Bairro VARCHAR(90) NOT NULL,
Cidade VARCHAR(90) NOT NULL,
Estado VARCHAR(90) NOT NULL,
CEP VARCHAR(8) NOT NULL,
Complemento VARCHAR(45) NULL
);