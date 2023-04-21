{{/*
Expand the name of the chart.
*/}}
{{- define "auth.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "auth.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "auth.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "auth.labels" -}}
helm.sh/chart: {{ include "auth.chart" . }}
{{ include "auth.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auth.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auth.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "auth.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "auth.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "masastack.ingress.server.annotations" -}}
kubernetes.io/ingress.class: nginx
kubernetes.io/load-balancer-port: "443"
kubernetes.io/load-balancer-protocol: TERMINATED_HTTPS
nginx.ingress.kubernetes.io/cors-allow-headers: DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization,elastic-apm-traceparent
nginx.ingress.kubernetes.io/cors-allow-methods: PUT, GET, POST, OPTIONS, DELETE
nginx.ingress.kubernetes.io/cors-allow-origin: '*'
nginx.ingress.kubernetes.io/enable-cors: "true"
nginx.ingress.kubernetes.io/proxy-connect-timeout: "3600"
nginx.ingress.kubernetes.io/ssl-redirect: "true"
{{- end }}

{{- define "masastack.ingress.ui.annotations" -}}
kubernetes.io/ingress.class: nginx
kubernetes.io/load-balancer-port: "443"
kubernetes.io/load-balancer-protocol: TERMINATED_HTTPS
nginx.ingress.kubernetes.io/affinity: cookie
nginx.ingress.kubernetes.io/backend-protocol: HTTPS
nginx.ingress.kubernetes.io/cors-allow-headers: DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization,elastic-apm-traceparent
nginx.ingress.kubernetes.io/cors-allow-methods: PUT, GET, POST, OPTIONS, DELETE
nginx.ingress.kubernetes.io/cors-allow-origin: '*'
nginx.ingress.kubernetes.io/enable-cors: "true"
nginx.ingress.kubernetes.io/proxy-body-size: 200m
nginx.ingress.kubernetes.io/proxy-buffer-size: 512k
nginx.ingress.kubernetes.io/proxy-buffers: 512 512k
nginx.ingress.kubernetes.io/proxy_busy_buffers_size: 256k
nginx.ingress.kubernetes.io/proxy_set_header: Connection upgrade
nginx.ingress.kubernetes.io/ssl-redirect: "true"
nginx.ingress.kubernetes.io/websocket-services: "true"
{{- end }}

{{- define "masastack.ingress.sso.annotations" -}}
kubernetes.io/ingress.class: nginx
kubernetes.io/load-balancer-port: "443"
kubernetes.io/load-balancer-protocol: TERMINATED_HTTPS
nginx.ingress.kubernetes.io/affinity: cookie
nginx.ingress.kubernetes.io/backend-protocol: HTTPS
nginx.ingress.kubernetes.io/cors-allow-headers: DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization,elastic-apm-traceparent
nginx.ingress.kubernetes.io/cors-allow-methods: PUT, GET, POST, OPTIONS, DELETE
nginx.ingress.kubernetes.io/cors-allow-origin: '*'
nginx.ingress.kubernetes.io/enable-cors: "true"
nginx.ingress.kubernetes.io/proxy-body-size: 200m
nginx.ingress.kubernetes.io/proxy-buffer-size: 512k
nginx.ingress.kubernetes.io/proxy-buffers: 512 512k
nginx.ingress.kubernetes.io/proxy_busy_buffers_size: 256k
nginx.ingress.kubernetes.io/proxy_set_header: Connection upgrade
nginx.ingress.kubernetes.io/ssl-redirect: "true"
nginx.ingress.kubernetes.io/websocket-services: "true"
{{- end }}