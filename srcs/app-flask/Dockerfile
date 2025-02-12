# Usa un'immagine Python leggera
FROM python:3.9-slim

# Imposta la directory di lavoro nel container
WORKDIR /app

# Copia i file dell'app nel container
COPY app.py /app/

# Installa Flask
RUN pip install flask

# Espone la porta 5000 (necessaria per accedere all'applicazione)
EXPOSE 5000

# Comando per avviare l'applicazione
CMD ["python", "app.py"]


# TESTARLA:
# docker build -t app-flask .
# docker run -p 5000:5000 app-flask
# POI VISITARE http://localhost:5000/ NEL BROWSER