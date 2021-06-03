Kubernetes Sync
---

This chart packages up [kubectl-opslevel](https://github.com/OpsLevel/kubectl-opslevel) and runs it as a `cronjob` in Kubernetes to periodically sync Kubernetes data with OpsLevel.

Make sure you have the [OpsLevel Helm chart](https://github.com/OpsLevel/helm-charts) repository added then you can perform an install with:

```
helm install opslevel/kubernetes-sync sync --namespace=opslevel --create-namespace --set-file sync.config=./opslevel-k8s.yaml --set sync.schedule="0 12 * * 1" --set apitoken=XXXXX 
```

To upgrade

```
helm upgrade --namespace=opslevel --set-file sync.config=./opslevel-k8s.yaml --set apitoken=XXXXX sync opslevel/kubernetes-sync
```
