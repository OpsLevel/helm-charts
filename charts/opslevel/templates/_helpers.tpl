{{- define "opslevel.pullSecrets" -}}
      {{- if (.Values.global.dockerconfigjson | default (.Values.global.replicated).dockerconfigjson | default false ) }}
      imagePullSecrets:
        - name: opslevel-pull-secret
      {{- end }}
{{- end }}

{{- define "global.nodeSelector" -}}
      {{- if .Values.global.nodeSelector }}
      nodeSelector:
        kubernetes.io/os: '{{ .Values.global.nodeSelector }}'
      {{- end }}
{{- end }}

{{- define "opslevel.integration.secrets" -}}
{{- if .Values.integrations.azureDevOps.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.azureDevOps.secret.name }}'
{{- end }}
{{- if .Values.integrations.bitbucket.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.bitbucket.secret.name }}'
{{- end }}
{{- if .Values.integrations.github.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.github.secret.name }}'
{{- end }}
{{- if .Values.integrations.gitlab.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.gitlab.secret.name }}'
{{- end }}
{{- if .Values.integrations.jira.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.jira.secret.name }}'
{{- end }}
{{- if .Values.integrations.pagerduty.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.pagerduty.secret.name }}'
{{- end }}
{{- if .Values.integrations.slack.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.slack.secret.name }}'
{{- end }}
{{- end }}

{{- define "github.install.url" -}}
https://github.com/apps/{{ .Values.integrations.github.secret.app_name | urlquery }}/installations/new
{{- end }}

{{- define "opslevel.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.opslevel.image.repository }}:{{ .Values.opslevel.image.tag }}
{{- end }}

{{- define "opssight.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.opssight.image.repository }}:{{ .Values.opssight.image.tag }}
{{- end }}

{{- define "mysql.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.mysql.image.repository }}:{{ .Values.mysql.image.tag }}
{{- end }}

{{- define "redis.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.redis.image.repository }}:{{ .Values.redis.image.tag }}
{{- end }}

{{- define "postgres.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.postgres.image.repository }}:{{ .Values.postgres.image.tag }}
{{- end }}

{{- define "elasticsearch.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.elasticsearch.image.repository }}:{{ .Values.elasticsearch.image.tag }}
{{- end }}

{{- define "objectStorage.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.objectStorage.image.repository }}:{{ .Values.objectStorage.image.tag }}
{{- end }}

{{- define "runner.image" -}}
{{ .Values.runner.image.repository }}:{{ .Values.runner.image.tag }}
{{- end }}

{{- define "opssight.redisURL" -}}
redis://{{ .Values.redis.secret.host }}:{{ .Values.redis.secret.port }}/0
{{- end }}
