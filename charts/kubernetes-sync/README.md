Kubernetes Sync
---

This chart packages up [kubectl-opslevel](https://github.com/OpsLevel/kubectl-opslevel) and runs it as a `cronjob` in Kubernetes to periodically sync Kubernetes data with OpsLevel.

Make sure you have the OpsLevel Helm chart repository added.

```
helm repo add opslevel https://opslevel.github.com/helm-charts
helm repo update
helm search repo opslevel
```

Then you can perform an install with:

```
helm install opslevel/kubernetes-sync --set-file sync.config=./opslevel-k8s.yaml -set apitoken=XXXXX
```
