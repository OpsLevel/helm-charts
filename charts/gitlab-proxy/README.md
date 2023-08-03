Gitlab Proxy
---

This chart packages up [caddy]() a proxy configured for Gitlab.com requests from Opslevel so you do not have to give OpsLevel your real Gitlab.com credentials.

Make sure you have the [OpsLevel Helm chart](https://github.com/OpsLevel/helm-charts) repository added then you can perform an installation with:

```
cat << EOF > values.yaml
real_token: "Your Real Gitlab Token"
dummy_token: "The Dummy Token you give Opslevel"
EOF
helm install --namespace=opslevel --create-namespace -f values.yaml gitlab-proxy opslevel/gitlab-proxy
```

To upgrade

```
helm upgrade --namespace=opslevel -f values.yaml gitlab-proxy opslevel/gitlab-proxy
```