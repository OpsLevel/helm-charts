{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "utils.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "utils.name" -}}
{{- default .Chart.Name .Values.name | lower | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "utils.labels" -}}
helm.sh/chart: {{ include "utils.chart" . }}
{{ include "utils.selectorLabels" . }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end}}

{{/*
Selector labels
*/}}
{{- define "utils.selectorLabels" -}}
app.kubernetes.io/name: {{ include "utils.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | lower }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.selectorLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}