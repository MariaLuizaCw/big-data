# Trabalho Big Data - Grupo Syma

## Integrantes do grupo

- Igor Telles - 120040283
- Sylvio Mello - 119093388
- Maria Luiza C. Wuillaume - 120040005
- Felipe Vilela - 119093087 

## Documentação do Projeto

### Modelos de Dados da Empresas

É possível encontrar os modelo de dados dos bancos de dados das empresas dos grupos do Antonny, da Rayssa, do Siqueira e do nosso grupo na pasta [sql](sql). Nesta pasta também há o [SQL](sql/tabelaDimensoesFatos.sql) que gera as tabelas de fatos e dimensões.

### Extração ETL das informações das tabelas fontes de dados para a área de stage do DWH, tanto a partir do esquema que o grupo projetou, como dos esquemas projetados por outro três grupos da turma

Arquivo: [extract.py](extract.py)

### Transformações ETL necessárias para integrar e conformar as fontes de dados escolhidas

Arquivo: [ETL.py](ETL.py)

### Carga das tabelas de fatos e dimensões do DWH a partir das tabelas transformadas que estão no stage

Arquivo: [ETL.py](ETL.py)

### Geração dos relatórios e da matriz de percentuais de movimentação entre pátios

