# Importiamo la classe Flask dalla libreria Flask, che serve per creare un'applicazione web.
from flask import Flask

# Importiamo la classe datetime dalla libreria datetime per gestire la data e l'ora.
from datetime import datetime

import os  # Importiamo il modulo os per accedere alle variabili d'ambiente del sistema.

# Creiamo un'istanza di Flask, che rappresenta la nostra applicazione web.
# In Python, __name__ è una variabile speciale che contiene il nome del modulo attualmente in esecuzione.
# Se il file viene eseguito direttamente (ad esempio con python mio_script.py), allora __name__ avrà il valore "__main__".
app = Flask(__name__)

# Definiamo una route (un endpoint HTTP) che risponde alle richieste fatte alla radice ('/').
@app.route('/')
def home():  # Definiamo la funzione che verrà eseguita quando un utente accede all'endpoint '/'
    agent_name = os.getenv('AGENT_NAME', '...')  # Usa la variabile d'ambiente AGENT_NAME, con 'AgenteX' come valore di default
    
    # Otteniamo l'orario attuale formattato in ore e minuti (es. "14:30").
    current_time = datetime.now().strftime("%H:%M")  
    
    # Restituiamo una stringa che contiene il nome dell'agente e l'orario attuale.
    return f"Ciao, mi chiamo {agent_name}. Sono le ore {current_time}"

# Definiamo un secondo endpoint chiamato '/health' per il controllo dello stato del servizio.
@app.route('/health')
def health_check():  # Funzione che viene eseguita quando si accede all'endpoint '/health'
    return "OK", 200  # Restituisce la stringa "OK" con il codice HTTP 200 (che indica successo).

# Se questo file viene eseguito direttamente (e non importato come modulo in un altro script)...
if __name__ == '__main__':
    # Avviamo il server Flask e lo rendiamo accessibile su tutte le interfacce di rete (0.0.0.0) sulla porta 5000.
    app.run(host='0.0.0.0', port=5000)
