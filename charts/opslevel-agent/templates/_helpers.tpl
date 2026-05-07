{{- define "agent.image" -}}
{{ .Values.agent.image.repository }}:{{ .Values.agent.image.tag }}{{- if .Values.agent.image.digest }}@{{ .Values.agent.image.digest }}{{- end }}
{{- end }}