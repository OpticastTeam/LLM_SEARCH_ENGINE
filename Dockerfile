# # Dockerfile
FROM python:3.11-slim

# Installer les dépendances système
RUN apt update && apt install -y \
    build-essential \
    libpoppler-cpp-dev \
    poppler-utils \
    && apt clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# Installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code de l'application
COPY . /app
WORKDIR /app

# Exposer le port Streamlit
EXPOSE 8501

# Commande pour lancer Streamlit
CMD ["streamlit", "run", "streamlit_app.py", "--server.port=8501", "--server.address=0.0.0.0"]


