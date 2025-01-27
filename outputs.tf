output "id" {
  value = resource.null_resource.this.id
}

output "grafana_admin_password" {
  description = "The admin password for Grafana."
  value       = local.grafana.admin_password
  sensitive   = true
}

output "grafana_enabled" {
  value = local.grafana.enabled
}

output "prometheus_enabled" {
  value = local.prometheus.enabled
}

output "alertmanager_enabled" {
  value = local.alertmanager.enabled
}
