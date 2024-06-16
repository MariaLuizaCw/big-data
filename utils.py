import pandas as pd

def format_addresses(tables_df, insert_table_name):
    insert_df = tables_df[insert_table_name]
    address_df = tables_df["Endereco"]

    address_dict = {}
    for _, row in address_df.iterrows():
        address_str = f"{row['Rua']}, {row['Numero']} - {row['Complemento']} - {row['CEP']}"
        address_dict[row['ID_Endereco']] = address_str

    insert_df['Endereco'] = insert_df['ID_Endereco'].map(address_dict)
    insert_df.drop(columns=['ID_Endereco'], inplace=True)

    tables_df[insert_table_name] = insert_df 

    return tables_df

def remove_unused_tables(unused_tables, tables_df):
    for t in unused_tables:
        tables_df.pop(t)
    return tables_df
