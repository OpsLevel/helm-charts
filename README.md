<img align="right" src="logo.png" width="175" height="175">

# OpsLevel Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/opslevel)](https://artifacthub.io/packages/search?repo=opslevel)


Official Helm charts for OpsLevel products. Currently supported:

- [Kubernetes Sync](https://github.com/OpsLevel/helm-charts/tree/main/charts/kubernetes-sync) (opslevel/kubectl-opslevel)

## How to use OpsLevel Helm repository

You need to add this repository to your Helm repositories:

```
helm repo add opslevel https://opslevel.github.io/helm-charts
helm repo update
helm search repo opslevel
```
