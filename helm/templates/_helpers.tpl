{{/*
Expand the name of the chart.
*/}}
{{- define "hello-world-springbootapp.name" -}}
{{- default .Chart.Name .Values.appName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "hello-world-springbootapp.fullname" -}}
{{- default .Chart.Name .Values.appName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Chart label used in metadata.
*/}}
{{- define "hello-world-springbootapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels applied to all resources.
*/}}
{{- define "hello-world-springbootapp.labels" -}}
app: {{ include "hello-world-springbootapp.fullname" . }}
app.kubernetes.io/name: {{ include "hello-world-springbootapp.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "hello-world-springbootapp.fullname" . }}
helm.sh/chart: {{ include "hello-world-springbootapp.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Selector labels used by Deployment selectors and Service selectors.
*/}}
{{- define "hello-world-springbootapp.selectorLabels" -}}
app: {{ include "hello-world-springbootapp.fullname" . }}
app.kubernetes.io/name: {{ include "hello-world-springbootapp.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
