# Utiliser une image de base légère avec Python préinstallé
FROM python:3.11-slim

# Installer les dépendances système nécessaires
RUN apt update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Télécharger et installer Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Télécharger les modèles nécessaires
RUN ollama pull llama:3.2 && \
    ollama pull nomic-embed-text

# Installer les dépendances Python nécessaires pour l'application
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install --no-cache-dir -r requirements.txt

# Copier le code de l'application dans l'image
COPY . /app

# Configurer le point d'entrée ou le script de démarrage
CMD ["streamlit", "run", "streamlit_app.py"]

