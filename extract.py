import pandas as pd
from sqlalchemy import create_engine
import os

def get_db_connection(db_type, db_url):
    if db_type == "postgresql":
        engine = create_engine(db_url)
    elif db_type == "mssql":
        engine = create_engine(f"mssql+pyodbc:///?odbc_connect={db_url}")
    else:
        raise ValueError("Unsupported database type")
    return engine.connect()

def extract_data(connection, table_name):
    query = f"SELECT * FROM {table_name}"
    df = pd.read_sql(query, connection)
    return df

def load_data_to_filesystem(df, directory, file_name):
    if not os.path.exists(directory):
        os.makedirs(directory)
    file_path = os.path.join(directory, file_name)
    df.to_csv(file_path, index=False)

def etl_process(db_configs, company_tables, base_directory):
    for company, tables in company_tables.items():
        db_config = db_configs[company]
        db_type = db_config['type']
        db_url = db_config['url']
        connection = get_db_connection(db_type, db_url)
        
        company_directory = os.path.join(base_directory, company)
        
        for table_name in tables:
            df = extract_data(connection, table_name)
            file_name = f"{table_name}.csv"
            load_data_to_filesystem(df, company_directory, file_name)
        
        connection.close()

# Configurações de banco de dados para cada locadora
db_configs = {
    'SYMA': {'type': 'postgresql', 'url': 'postgresql://user:password@localhost:5432/db1'},
    'ANTONNY': {'type': 'postgresql', 'url': 'postgresql://user:password@localhost:5432/db1'},
    'SIQUEIRA': {'type': 'postgresql', 'url': 'postgresql://user:password@localhost:5432/db1'},
    'RAYSSA': {'type': 'mssql', 'url': 'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=db4;UID=user;PWD=password'}

}

# Dicionário com nomes das locadoras e suas respectivas tabelas
company_tables = {
    'SYMA':     ['Grupo_Categoria', 'Veiculo', 'Cliente', 'Reserva', 'Locacao', 'Patio'],
    'RAYSSA':   ['Categoria', 'Veiculo', 'Cliente', 'Reserva', 'Locacao', 'Patio'],
    'SIQUEIRA': ['Veículos','Clientes', 'Reservas', 'Locações', 'Pátios'],
    'ANTONNY':  ['Grupos_Veículos', 'Veículos', 'Clientes', 'Reservas', 'Locações', 'Endereço', 'Prontuário']
}

# Diretório base onde as pastas das locadoras serão criadas
base_directory = '/path/to/stage/directory'

# Executa o processo ETL
etl_process(db_configs, company_tables, base_directory)
