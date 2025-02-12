# TABLE OG CONTENTS:
- [SOURCES](#sources)
- [MINIKUBE](#minikube)
- [HELM](#helm)


***

# SOURCES:
- **Jenskins**:
    - [Learn Jenkins! Complete Jenkins Course - Zero to Hero](https://www.youtube.com/watch?v=6YZvp2GwT0A)
- **Nexus**:
    - [Medium](https://medium.com/@chiemelaumeh1/install-sonatype-nexus-3-using-docker-compose-setup-nexus-repository-manager-for-node-js-project-47a3c5efe1ee)
- **Helm**:
    - [TechWorld with Nana](https://www.youtube.com/watch?v=-ykwb1d0DXU)



***
# MINIKUBE

## Cos'è Minikube?
Minikube è uno strumento che consente di eseguire un cluster Kubernetes in locale. È particolarmente utile per lo sviluppo, i test e l'apprendimento di Kubernetes senza la necessità di un'infrastruttura cloud o un cluster distribuito.

## Caratteristiche principali di Minikube
✔ **Singolo nodo (per default)**: Crea un cluster Kubernetes a nodo singolo, ma può essere esteso a più nodi.
✔ **Supporto a diversi driver**: Può essere eseguito su Docker, KVM, VirtualBox e altri hypervisor.
✔ **Compatibilità con Kubernetes**: Permette di testare e sviluppare applicazioni come su un cluster reale.
✔ **Facilità d'uso**: Include comandi semplici per avviare, fermare ed eliminare il cluster.
✔ **Supporto a funzionalità avanzate**: Dashboard, ingress controller, storage e altro.


## Come funziona?
Minikube avvia una macchina virtuale (o un container, se usi Docker) che contiene tutti i componenti essenziali di Kubernetes, tra cui:

- API Server
- Scheduler
- Controller Manager
- Etcd
- Kubelet e Kube-Proxy
Questo permette agli sviluppatori di testare workload Kubernetes in un ambiente locale.

## Utilizzo
### 1. Installazione di Minikube e Kubectl

**Fedora**
```bash
sudo dnf install -y kubectl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### 2. Avvio del Cluster
Dopo l'installazione, avvia un cluster con il driver desiderato. Minikube supporta diversi driver (virtualizzazione con docker, podman, kvm2, etc.).

es:
```bash
minikube start --driver=docker
```

Posso poi controllare i nodi con:
```bash
kubectl get nodes
```

### 3. Configurazione Avanzata
Per personalizzare le risorse allocate (CPU, RAM, disco), usa:
```bash
minikube start --cpus=4 --memory=8192 --disk-size=20g --driver=docker
```

### 4. Fermare e Eliminare il Cluster
Per stoppare temporaneamente Minikube:
```bash
minikube stop
```

Per eliminare completamente il cluster:
```bash
minikube delete
```


***

# HELM
Helm è un gestore di pacchetti per Kubernetes che semplifica il deployment, l'aggiornamento e la gestione delle applicazioni all'interno di un cluster. Funziona in modo simile a apt per Debian o yum per CentOS, ma per Kubernetes, permettendo di installare applicazioni complesse con pochi comandi.


## Concetti chiave di Helm
- **Chart**
    Un Chart è un pacchetto Helm che contiene tutto il necessario per distribuire un'applicazione su Kubernetes:
    - Template dei file YAML (Deployment, Service, ConfigMap, ecc.)
    - Variabili personalizzabili (values.yaml)
    - Metadata e documentazione
- **Release**
    Una Release è un'istanza di un Chart installata nel cluster. È possibile avere più release dello stesso Chart con configurazioni diverse.

- **Repository**
    I Chart vengono distribuiti attraverso repository Helm, simili ai repository di pacchetti di Linux. Un esempio noto è il repository ufficiale Helm Stable.


## Installazione di Helm (Fedora)
```bash
sudo dnf install helm
```

## Creazione di una Chart personalizzata

### 1. Creazione della Chart
Per generare la struttura di base della Chart, usiamo il comando:
```bash
helm create mia-chart
```

Questo comando creerà una directory, nel percorso in cui andrò ad eseguirlo, chiamata mia-chart con la seguente struttura:
```graphql
mia-chart/
│── charts/           # Altri chart dipendenti (se presenti)
│── templates/        # Template YAML dei manifest di Kubernetes
│   │── _helpers.tpl  # File con variabili e funzioni di supporto
│   │── deployment.yaml
│   │── service.yaml
│   │── ingress.yaml  (se necessario)
│── values.yaml       # Configurazioni personalizzabili
│── Chart.yaml        # Metadata della Chart
│── .helmignore       # File ignorati (simile a .gitignore)
```

### 2. Modifica dei file della Chart
#### 2.1 Chart.yaml
Contiene i metadati del tuo Chart. Esempio:
```yaml
apiVersion: v2
name: mia-chart
description: Una Chart personalizzata per la mia applicazione
type: application
version: 0.1.0
appVersion: 1.0.0
```

#### 2.2 Modifica dei template
I file nella cartella templates/ sono template YAML di Kubernetes. Ad esempio, il deployment.yaml potrebbe essere così:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-app
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}-app
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}-app
    spec:
      containers:
        - name: mia-app
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: {{ .Values.service.port }}
```


#### 2.3 Personalizzazione dei valori (values.yaml)
Nel file values.yaml possiamo definire i valori predefiniti che possono essere sovrascritti dall'utente:
```yaml
replicaCount: 2

image:
  repository: nginx
  tag: latest

service:
  type: ClusterIP
  port: 80
```

### 3.  Installare e testare la Chart

#### 3.1 Installare la Chart
Eseguiamo il deployment con:
```bash
helm install mia-release ./mia-chart
```

#### 3.2 Verificare le risorse create
Dopo l'installazione, possiamo controllare le risorse con:
```bash
kubectl get all
```

#### 3.3 Aggiornare la Chart
Se andremo a modificare il Chart, potremo aggiornare la release esistente con:
```bahs
helm upgrade mia-release ./mia-chart
```

#### 3.4 Disinstallare la Chart
Per rimuovere l'installazione:
```bash
helm uninstall mia-release
```