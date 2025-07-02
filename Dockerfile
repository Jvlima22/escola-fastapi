# Use uma imagem oficial do Python como imagem base
# A versão 3.10-slim é leve e corresponde ao pré-requisito do projeto
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Fazemos isso primeiro para aproveitar o cache de camadas do Docker
COPY requirements.txt .

# Instala as dependências do projeto
# A flag --no-cache-dir reduz o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do container
EXPOSE 8000

# Comando para executar a aplicação quando o container for iniciado
# Usamos --host 0.0.0.0 para tornar a aplicação acessível na rede
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]