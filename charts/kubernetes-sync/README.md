Kubernetes Sync
---

This chart for [kubectl-opslevel](https://github.com/OpsLevel/kubectl-opslevel) creates a deployment
to run the app in the background using `$ kubectl-opslevel service reconcile`.

The app attaches to the Kubernetes event stream and listens for any create and update events.
These are then processed by the tool and the resulting service data is sent OpsLevel.

Make sure you have the [OpsLevel Helm chart](https://github.com/OpsLevel/helm-charts) repository added.

## Deploy

```bash
# double check that you are in the correct cluster
kctx

# double check that your config file is correct
cat opslevel-k8s.yaml

# export API token and desired namespace (defaults to 'opslevel')
 OPSLEVEL_API_TOKEN="..." NAMESPACE="..."

#
#   IF INSTALLING FOR THE FIRST TIME:
#
helm install sync opslevel/kubernetes-sync \
    --namespace="${NAMESPACE:-opslevel}" \
    --create-namespace \
    --set-file sync.config=./opslevel-k8s.yaml \
    --set apitoken="$OPSLEVEL_API_TOKEN"

#
#   RE-DEPLOYS:
#
helm upgrade sync opslevel/kubernetes-sync \
    --namespace="${NAMESPACE:-opslevel}" \
    --set-file sync.config=./opslevel-k8s.yaml \
    --set apitoken="$OPSLEVEL_API_TOKEN"
```

## Deploy without using our public container registry

To deploying using an image from your own registry, edit this line in [values.yaml](./values.yaml):

```
image: public.ecr.aws/opslevel/kubectl-opslevel:v2024.2.26
```

and then deploy using `helm`.
