{{- define "agent.image" -}}
{{ .Values.agent.image.repository }}:{{ .Values.agent.image.tag }}
{{- end }}