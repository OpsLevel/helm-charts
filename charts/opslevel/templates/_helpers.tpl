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
{{- if .Values.integrations.aws.enabled }}
            - secretRef:
                name: '{{ .Values.integrations.aws.secret.name }}'
{{- end }}
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
https://github.com/apps/{{ required "please provide 'integrations.github.secret.appName'" .Values.integrations.github.secret.appName | urlquery }}/installations/new
{{- end }}

{{- define "opslevel.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.opslevel.image.repository }}:{{ .Values.opslevel.image.tag }}{{- if .Values.opslevel.image.digest }}@{{ .Values.opslevel.image.digest }}{{- end }}
{{- end }}

{{- define "opssight.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.opssight.image.repository }}:{{ .Values.opssight.image.tag }}{{- if .Values.opssight.image.digest }}@{{ .Values.opssight.image.digest }}{{- end }}
{{- end }}

{{- define "mysql.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.mysql.image.repository }}:{{ .Values.mysql.image.tag }}{{- if .Values.mysql.image.digest }}@{{ .Values.mysql.image.digest }}{{- end }}
{{- end }}

{{- define "redis.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.redis.image.repository }}:{{ .Values.redis.image.tag }}{{- if .Values.redis.image.digest }}@{{ .Values.redis.image.digest }}{{- end }}
{{- end }}

{{- define "postgres.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.postgres.image.repository }}:{{ .Values.postgres.image.tag }}{{- if .Values.postgres.image.digest }}@{{ .Values.postgres.image.digest }}{{- end }}
{{- end }}

{{- define "elasticsearch.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.elasticsearch.image.repository }}:{{ .Values.elasticsearch.image.tag }}{{- if .Values.elasticsearch.image.digest }}@{{ .Values.elasticsearch.image.digest }}{{- end }}
{{- end }}

{{- define "objectStorage.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.objectStorage.image.repository }}:{{ .Values.objectStorage.image.tag }}{{- if .Values.objectStorage.image.digest }}@{{ .Values.objectStorage.image.digest }}{{- end }}
{{- end }}

{{- define "objectStorageCLI.image" -}}
{{ .Values.objectStorage.image.repositoryCLI }}:{{ .Values.objectStorage.image.tagCLI }}{{- if .Values.objectStorage.image.digestCLI }}@{{ .Values.objectStorage.image.digestCLI }}{{- end }}
{{- end }}

{{- define "runner.image" -}}
{{ .Values.runner.image.repository }}:{{ .Values.runner.image.tag }}{{- if .Values.runner.image.digest }}@{{ .Values.runner.image.digest }}{{- end }}
{{- end }}

{{- define "faktory.image" -}}
{{ .Values.global.proxy }}{{if .Values.global.proxy }}/{{ end }}{{ .Values.faktory.image.repository }}:{{ .Values.faktory.image.tag }}{{- if .Values.faktory.image.digest }}@{{ .Values.faktory.image.digest }}{{- end }}
{{- end }}

{{- define "faktory.url" -}}
tcp://admin:{{ .Values.faktory.secret.password }}@faktory:7419
{{- end }}