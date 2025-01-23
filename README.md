<img align="right" src="logo.png" width="175" height="175">

# OpsLevel Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/opslevel)](https://artifacthub.io/packages/search?repo=opslevel)


Official Helm charts for OpsLevel products. Currently supported:

- [OpsLevel Self Hosted](https://github.com/OpsLevel/helm-charts/tree/main/charts/kubernetes-sync) (opslevel/opslevel) (requires license)
- [OpsLevel Agent](https://github.com/OpsLevel/helm-charts/tree/main/charts/kubernetes-sync) (opslevel/opslevel-agent)
- [Gitlab Proxy](https://github.com/OpsLevel/helm-charts/tree/main/charts/gitlab-proxy) (opslevel/gitlab-proxy)

### End Of Life

- [Kubernetes Sync](https://github.com/OpsLevel/helm-charts/tree/main/charts/kubernetes-sync) (opslevel/kubectl-opslevel)

## How to use OpsLevel Helm repository

You need to add this repository to your Helm repositories:

```
helm repo add opslevel https://opslevel.github.io/helm-charts
helm repo update
helm search repo opslevel
```
