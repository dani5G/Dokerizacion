# Imagen base 
FROM python:3.11-slim

# Metadatos 
LABEL author="Daniela Auquilla"
LABEL version="1.0.0"
LABEL description="NoticeBoard - Tablero de anuncios colaborativo"

# Variables de entorno 
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=5000
ENV FLASK_DEBUG=0

# Directorio de trabajo 
WORKDIR /app

# Dependencias (capa separada) 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Código fuente 
COPY . .

# Usuario no-root 
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# Puerto 
EXPOSE 5000

# Arranque 
CMD ["python", "run.py"]