# # Dockerfile
FROM python:3.11-slim

# Installer les dépendances système
RUN apt update && apt-get install -y \
    build-essential \
    libpoppler-cpp-dev \
    poppler-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code de l'application
COPY . /app
WORKDIR /app

# Exposer le port Streamlit
EXPOSE 8501

# Commande pour lancer Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]


