# OpsLevel Helm Charts

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/opslevel)](https://artifacthub.io/packages/search?repo=opslevel) 

Official Helm charts for OpsLevel products. Currently supported:

- [Kubernetes Sync](charts/kubernetes-sync) (opslevel/kubectl-opslevel)

## How to use OpsLevel Helm repository

You need to add this repository to your Helm repositories:

```
helm repo add opslevel https://opslevel.github.io/helm-charts
helm repo update
helm search repo opslevel
```
