Kubernetes Sync
---

This chart packages up [kubectl-opslevel](https://github.com/OpsLevel/kubectl-opslevel) and runs it as a `deployment` using the command `service reconcile` to attach to the Kubernetes event stream for any create and update events.  These are then processed by the tool and resulting service data is sent OpsLevel.

Make sure you have the [OpsLevel Helm chart](https://github.com/OpsLevel/helm-charts) repository added then you can perform an install with:

```
helm install opslevel/kubernetes-sync sync --namespace=opslevel --create-namespace --set-file sync.config=./opslevel-k8s.yaml --set apitoken=XXXXX 
```

To upgrade

```
helm upgrade --namespace=opslevel --set-file sync.config=./opslevel-k8s.yaml --set apitoken=XXXXX sync opslevel/kubernetes-sync
```
