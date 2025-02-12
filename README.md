# TABLE OG CONTENTS:
- [SOURCES](#sources)
- [MINIKUBE](#minikube)


***

# SOURCES:
- **Jenskins**:
    - [Learn Jenkins! Complete Jenkins Course - Zero to Hero](https://www.youtube.com/watch?v=6YZvp2GwT0A)
- **Nexus**:
    - [Medium](https://medium.com/@chiemelaumeh1/install-sonatype-nexus-3-using-docker-compose-setup-nexus-repository-manager-for-node-js-project-47a3c5efe1ee)



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