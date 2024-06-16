import pandas as pd
import glob
import os

# Define the path to the data directories
data_directories = {
    'syma': '/mnt/data/syma',
    'rayssa': '/mnt/data/rayssa',
    'antonny': '/mnt/data/antonny',
    'siqueira': '/mnt/data/siqueira'
}

# Function to read CSVs from a directory and concatenate them
def read_csv_from_directory(directory, table_name):
    file_path = os.path.join(directory, f"{table_name}.csv")
    if os.path.exists(file_path):
        return pd.read_csv(file_path)
    return pd.DataFrame()

# Read and integrate data for each table
def integrate_data(data_directories):
    dim_cliente = pd.DataFrame(columns=[
        'ID_Cliente', 'ID_Cliente_Syma', 'ID_Cliente_Rayssa', 'ID_Cliente_Antonny', 'ID_Cliente_Siqueira',
        'Nome', 'Tipo_Cliente', 'Documento', 'Endereco', 'Telefone', 'Email', 'CNH', 'Data_Validade_CNH', 'Data_Nascimento',
        'Created_at', 'Updated_at'
    ])

    dim_veiculo = pd.DataFrame(columns=[
        'ID_Veiculo', 'ID_Veiculo_Syma', 'ID_Veiculo_Rayssa', 'ID_Veiculo_Antonny', 'ID_Veiculo_Siqueira',
        'Placa', 'Chassis', 'ID_Grupo', 'Marca', 'Modelo', 'Cor', 'Ar_Condicionado', 'Mecanizacao', 'Cadeirinha',
        'Dimensoes', 'Foto', 'Created_at', 'Updated_at'
    ])

    dim_categoria = pd.DataFrame(columns=[
        'ID_Categoria', 'ID_Categoria_Syma', 'ID_Categoria_Rayssa', 'ID_Categoria_Antonny',
        'Nome_Categoria', 'Valor_por_Dia'
    ])

    dim_patio = pd.DataFrame(columns=[
        'ID_Patio', 'ID_Patio_Syma', 'ID_Patio_Rayssa', 'ID_Patio_Antonny', 'ID_Patio_Siqueira',
        'Nome', 'Localizacao', 'Capacidade', 'Created_at', 'Updated_at'
    ])

    fato_reserva = pd.DataFrame(columns=[
        'ID_Reserva', 'ID_Reserva_Syma', 'ID_Reserva_Rayssa', 'ID_Reserva_Antonny', 'ID_Reserva_Siqueira',
        'ID_Cliente', 'ID_Veiculo', 'ID_Patio', 'Data_Reserva', 'Data_Prevista_Retirada', 'Data_Prevista_Devolucao',
        'Valor_Reserva', 'Status_Reserva', 'Created_at', 'Updated_at'
    ])

    fato_locacao = pd.DataFrame(columns=[
        'ID_Locacao', 'ID_Locacao_Syma', 'ID_Locacao_Rayssa', 'ID_Locacao_Antonny', 'ID_Locacao_Siqueira',
        'ID_Reserva', 'ID_Cliente', 'ID_Veiculo', 'ID_Patio_Retirado', 'ID_Patio_Devolucao',
        'Data_Retirada', 'Data_Devolucao_Realizada', 'Valor_Locacao', 'Protecoes_Adicionais',
        'Created_at', 'Updated_at'
    ])

    for company, directory in data_directories.items():
        cliente = read_csv_from_directory(directory, 'Cliente')
        veiculo = read_csv_from_directory(directory, 'Veiculo')
        categoria = read_csv_from_directory(directory, 'Categoria')
        patio = read_csv_from_directory(directory, 'Patio')
        reserva = read_csv_from_directory(directory, 'Reserva')
        locacao = read_csv_from_directory(directory, 'Locacao')

        # Integrate Cliente data
        if not cliente.empty:
            for index, row in cliente.iterrows():
                if company == 'syma':
                    dim_cliente = dim_cliente.append({
                        'ID_Cliente_Syma': row['ID_Cliente'],
                        'Nome': row['Nome'],
                        'Tipo_Cliente': row['Tipo'],
                        'Documento': row['CPF_CNPJ'],
                        'Endereco': row['Endereco'],
                        'Telefone': row['Telefone'],
                        'Email': row['Email'],
                        'CNH': row['Numero_CNH'],
                        'Data_Validade_CNH': row['Validade_CNH'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    dim_cliente = dim_cliente.append({
                        'ID_Cliente_Rayssa': row['Cd_Cliente'],
                        'Nome': row['Nm_Nome'],
                        'Tipo_Cliente': row['Ds_Tipo'],
                        'Documento': row['Cd_CNPJ_CPF'],
                        'Endereco': row['Ds_Endereco'],
                        'Telefone': row['Nu_Telefone'],
                        'Email': row['Ds_Email'],
                        'CNH': row['Nu_CNH'],
                        'Data_Validade_CNH': row['Dt_Validade_CNH']
                    }, ignore_index=True)
                elif company == 'antonny':
                    dim_cliente = dim_cliente.append({
                        'ID_Cliente_Antonny': row['ID_Cliente'],
                        'Nome': row['Nome'],
                        'Tipo_Cliente': row['Tipo_Cliente'],
                        'Documento': row['Documento'],
                        'Endereco': row['ID_Endereco'],
                        'Telefone': row['Telefone'],
                        'Email': row['Email'],
                        'CNH': row['CNH'],
                        'Data_Validade_CNH': row['Data_Validade_CNH'],
                        'Data_Nascimento': row['Data_Nascimento']
                    }, ignore_index=True)
                elif company == 'siqueira':
                    dim_cliente = dim_cliente.append({
                        'ID_Cliente_Siqueira': row['ID'],
                        'Nome': row['Nome'],
                        'Tipo_Cliente': 'Pessoa Física' if row['PessoaFisica'] else 'Pessoa Jurídica',
                        'Documento': row['CPF_CNPJ'],
                        'Endereco': row['Endereco'],
                        'Telefone': row['Telefone'],
                        'Email': row['Email'],
                        'CNH': row['CNH'],
                        'Data_Validade_CNH': row['ExpiracaoCNH'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)

        # Integrate Veiculo data
        if not veiculo.empty:
            for index, row in veiculo.iterrows():
                if company == 'syma':
                    dim_veiculo = dim_veiculo.append({
                        'ID_Veiculo_Syma': row['ID_Veiculo'],
                        'Placa': row['Placa'],
                        'Marca': row['Marca'],
                        'Modelo': row['Modelo'],
                        'Cor': row['Cor'],
                        'Ar_Condicionado': row['Ar_Condicionado'],
                        'Dimensoes': row['Dimensoes'],
                        'Foto': row['Foto_URL'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    dim_veiculo = dim_veiculo.append({
                        'ID_Veiculo_Rayssa': row['Cd_Carro'],
                        'Placa': row['Nu_Placa'],
                        'Marca': row['Nm_Marca'],
                        'Modelo': row['Nm_Modelo'],
                        'Cor': row['Nm_Cor'],
                        'Ar_Condicionado': row['Ds_Ar_Condicionado'],
                        'Chassis': row['Nu_Chassi'],
                        'Dimensoes': f"{row['Nu_Altura']}x{row['Nu_Tamanho']}x{row['Nu_Largura']}",
                        'Foto': row['Ds_Foto']
                    }, ignore_index=True)
                elif company == 'antonny':
                    dim_veiculo = dim_veiculo.append({
                        'ID_Veiculo_Antonny': row['ID_Veículo'],
                        'Placa': row['Placa'],
                        'Marca': row['Marca'],
                        'Modelo': row['Modelo'],
                        'Cor': row['Cor'],
                        'Ar_Condicionado': row['Ar_Condicionado'],
                        'Mecanizacao': row['Mecanização'],
                        'Cadeirinha': row['Cadeirinha'],
                        'Foto': row['Link_Fotos'],
                        'Dimensoes': f"Tamanho: {row['Tamanho_Mala']} Carga: {row['Carga_Maxima']}"
                    }, ignore_index=True)
                elif company == 'siqueira':
                    dim_veiculo = dim_veiculo.append({
                        'ID_Veiculo_Siqueira': row['ID'],
                        'Placa': row['Placa'],
                        'Marca': row['Marca'],
                        'Modelo': row['Modelo'],
                        'Cor': row['Cor'],
                        'Ar_Condicionado': row['ArCondicionado'],
                        'Mecanizacao': 'Automática' if row['MecanizacaoAutomatica'] else 'Manual',
                        'Cadeirinha': row['Cadeirinha'],
                        'Dimensoes': f"{row['Largura']}x{row['Comprimento']}",
                        'Foto': row['Foto'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)

        # Integrate Categoria data
        if not categoria.empty:
            for index, row in categoria.iterrows():
                if company == 'syma':
                    dim_categoria = dim_categoria.append({
                        'ID_Categoria_Syma': row['ID_Grupo'],
                        'Nome_Categoria': row['Nome'],
                        'Valor_por_Dia': row['Faixa_Valor_Diaria']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    dim_categoria = dim_categoria.append({
                        'ID_Categoria_Rayssa': row['Cd_Categoria'],
                        'Nome_Categoria': row['Nm_Categoria'],
                        'Valor_por_Dia': row['Vl_Valor_por_Dia']
                    }, ignore_index=True)
                elif company == 'antonny':
                    dim_categoria = dim_categoria.append({
                        'ID_Categoria_Antonny': row['ID_Grupo'],
                        'Nome_Categoria': row['Nome_Grupo']
                    }, ignore_index=True)

        # Integrate Patio data
        if not patio.empty:
            for index, row in patio.iterrows():
                if company == 'syma':
                    dim_patio = dim_patio.append({
                        'ID_Patio_Syma': row['ID_Patio'],
                        'Nome': row['Nome'],
                        'Localizacao': row['Endereco'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    dim_patio = dim_patio.append({
                        'ID_Patio_Rayssa': row['Cd_Patio'],
                        'Nome': row['Nm_Patio']
                    }, ignore_index=True)
                elif company == 'antonny':
                    dim_patio = dim_patio.append({
                        'ID_Patio_Antonny': row['ID_Pátio'],
                        'Nome': row['ID_Endereco'],
                        'Capacidade': row['Capacidade']
                    }, ignore_index=True)
                elif company == 'siqueira':
                    dim_patio = dim_patio.append({
                        'ID_Patio_Siqueira': row['ID'],
                        'Nome': row['Nome'],
                        'Localizacao': row['Localizacao'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)

        # Integrate Reserva data
        if not reserva.empty:
            for index, row in reserva.iterrows():
                if company == 'syma':
                    fato_reserva = fato_reserva.append({
                        'ID_Reserva_Syma': row['ID_Reserva'],
                        'ID_Cliente': row['ID_Cliente'],
                        'ID_Veiculo': row['ID_Veiculo'],
                        'Data_Reserva': row['Data_Reserva'],
                        'Data_Prevista_Retirada': row['Data_Retirada'],
                        'Data_Prevista_Devolucao': row['Data_Devolucao'],
                        'Status_Reserva': row['Estado'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    fato_reserva = fato_reserva.append({
                        'ID_Reserva_Rayssa': row['Cd_Reserva'],
                        'ID_Cliente': row['Cd_Cliente'],
                        'ID_Veiculo': row['Cd_Carro'],
                        'Data_Reserva': row['Dt_Reserva'],
                        'Data_Prevista_Retirada': row['Dt_Entrega'],
                        'Data_Prevista_Devolucao': row['Dt_Devolucao'],
                        'Status_Reserva': row['Cd_Situacao']
                    }, ignore_index=True)
                elif company == 'antonny':
                    fato_reserva = fato_reserva.append({
                        'ID_Reserva_Antonny': row['ID_Reserva'],
                        'ID_Cliente': row['ID_Cliente'],
                        'ID_Veiculo': row['ID_Veículo'],
                        'ID_Patio': row['Pátio_Retirada'],
                        'Data_Reserva': row['Data_Reserva'],
                        'Data_Prevista_Retirada': row['Data_Início'],
                        'Data_Prevista_Devolucao': row['Data_Fim'],
                        'Status_Reserva': row['Status_Reserva']
                    }, ignore_index=True)
                elif company == 'siqueira':
                    fato_reserva = fato_reserva.append({
                        'ID_Reserva_Siqueira': row['ID'],
                        'ID_Cliente': row['ClienteId'],
                        'ID_Veiculo': row['VeiculoId'],
                        'ID_Patio': row['PatioId'],
                        'Data_Reserva': row['DataReserva'],
                        'Data_Prevista_Retirada': row['DataPrevistaRetirada'],
                        'Data_Prevista_Devolucao': row['DataPrevistaDevolucao'],
                        'Valor_Reserva': row['ValorReserva'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)

        # Integrate Locacao data
        if not locacao.empty:
            for index, row in locacao.iterrows():
                if company == 'syma':
                    fato_locacao = fato_locacao.append({
                        'ID_Locacao_Syma': row['ID_Locacao'],
                        'ID_Reserva': row['ID_Reserva'],
                        'Data_Retirada': row['Data_Retirada'],
                        'Data_Devolucao_Realizada': row['Data_Devolucao'],
                        'Valor_Locacao': row['Valor_Total'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
                elif company == 'rayssa':
                    fato_locacao = fato_locacao.append({
                        'ID_Locacao_Rayssa': row['Cd_Locacao'],
                        'ID_Cliente': row['Cd_Cliente'],
                        'ID_Patio_Retirado': row['Cd_Patio_Saida'],
                        'ID_Patio_Devolucao': row['Cd_Patio_Entrada'],
                        'Data_Retirada': row['Dt_Data_Retirada_Realizada'],
                        'Data_Devolucao_Realizada': row['Dt_Data_Devolucao_Realizada'],
                        'Protecoes_Adicionais': f"Farol: {row['Ds_Protecao_de_Farol']}, Vidro: {row['Ds_Protecao_de_Vidro']}"
                    }, ignore_index=True)
                elif company == 'antonny':
                    fato_locacao = fato_locacao.append({
                        'ID_Locacao_Antonny': row['ID_Locação'],
                        'ID_Reserva': row['ID_Reserva'],
                        'Data_Retirada': row['Data_Retirada'],
                        'Data_Devolucao_Realizada': row['Data_Devolução_Realizada'],
                        'Valor_Locacao': row['Valor_Aluguel'],
                        'ID_Patio_Retirado': row['Pátio_Retirada'],
                        'ID_Patio_Devolucao': row['Pátio_Devolução'],
                        'Status_Locacao': row['Status_Locação']
                    }, ignore_index=True)
                elif company == 'siqueira':
                    fato_locacao = fato_locacao.append({
                        'ID_Locacao_Siqueira': row['ID'],
                        'ID_Cliente': row['ClienteId'],
                        'ID_Veiculo': row['VeiculoId'],
                        'ID_Patio_Retirado': row['PatioRetiradoId'],
                        'ID_Patio_Devolucao': row['PatioDevolucaoId'],
                        'Data_Retirada': row['DataRetirada'],
                        'Data_Devolucao_Realizada': row['DataDevolucao'],
                        'Protecoes_Adicionais': row['Protecoes_Adicionais'],
                        'Created_at': row['Created_at'],
                        'Updated_at': row['Updated_at']
                    }, ignore_index=True)
