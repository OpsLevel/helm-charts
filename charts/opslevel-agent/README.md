OpsLevel Agent
---

This chart installs the [opslevel-agent]() for your kubernetes clusters

## Prerequisites

- Make sure you have the [OpsLevel Helm chart](https://github.com/OpsLevel/helm-charts) repository added.
- Make sure you have the ["kubernetes integration"](https://app.opslevel.com/integrations/new?name=kubernetes) installed in your opslevel account 

## Values.yaml

The bare minimum values file look like this

```yaml
secret:
  data:
    OPSLEVEL_API_TOKEN: "XXXXX"
```

```bash
helm install opslevel-agent opslevel/opslevel-agent -f values.yaml
```

## Multiple Clusters

If you intend to deploy the agent to multiple clusters you may want to create a unique 
integration tile in your OpsLevel account for each cluster so that you know which cluster the recommendations are coming from.
If you do this you'll need to specify the integration's alias in the values file you'll want the agent to submit for like this:

![integration_tile.png](integration_tile.png)

```yaml
agent:
  integration: "prod-cluster"
```

## Custom Data Mapping

Opslevel has added a [new integration type](https://docs.opslevel.com/docs/mapping-integration-data-to-custom-properties) that allows for mapping properties and relationships to components (and it supports suggestions)

To configuration the agent to send payloads at this integration:

```yaml
agent:
  integration: "https://app.opslevel.com/integrations/custom/webhook/XXXXXXXXXXXXXXXXXXXXXXX"
```

Then on the integration you can add extrators and transformers like this

```yaml
---
extractors:
- external_kind: apps_v1_Deployment
  external_id: ".metadata.uid"
  exclude: .metadata.namespace == "kube-system"
- external_kind: apps_v1_StatefulSet
  external_id: ".metadata.uid"
  exclude: .metadata.namespace == "kube-system"
- external_kind: v1_Namespace
  external_id: ".metadata.uid"
```

and

```
---
transforms:
- external_kind: v1_Namespace
  opslevel_kind: service
  opslevel_identifier: .metadata.name + "-service"
  on_component_not_found: suggest
- external_kind: apps_v1_Deployment
  opslevel_kind: runtime
  opslevel_identifier: ".metadata.name"
  on_component_not_found: suggest
  properties:
    namespace: ".metadata.namespace"
    containers: ".spec.template.spec | .containers + .initContainers | map(.image)"
    service: .metadata.annotations."opslevel.com/service" // (.metadata.namespace + "-service")
- external_kind: apps_v1_StatefulSet
  opslevel_kind: runtime
  opslevel_identifier: ".metadata.name"
  on_component_not_found: suggest
  properties:
    namespace: ".metadata.namespace"
    containers: ".spec.template.spec | .containers + .initContainers | map(.image)"
    service: .metadata.annotations."opslevel.com/service" // (.metadata.namespace + "-service")
```

Read our [integration documentation](https://docs.opslevel.com/docs/mapping-integration-data-to-custom-properties#configuration) for further information on whats possible in these configuration settings.

A handy tip for playing around with the mappings you can use the "Test Configuration" section by copying a kubernetes resource data to the sample payload using this simple command

```bash
kubectl get deployment <deployment_name> -o json | pbcopy
```

## Resource Targeting

By default the agent will target the following resources:

- v1/Service
- apps/v1/Deployment
- apps/v1/StatefulSet
- apps/v1/DaemonSet
- batch/v1/CronJob

but if you want other resource types to make suggestions you can add configuration so long as the
resource types show up when you use `kubectl api-resources --verbs="get,list"`.

The following restricts the agent to only syncronize Service and APIService resources:

```yaml
configmap:
  data:
    config.yaml: |
      selectors:
      - apiVersion: "v1"
        kind: Service
      - apiVersion: "apiregistration.k8s.io/v1"
        kind: APIService
```
