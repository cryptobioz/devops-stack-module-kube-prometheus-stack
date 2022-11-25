module "kube-prometheus-stack" {
  source = "../"

  cluster_name     = var.cluster_name
  argocd_namespace = var.argocd_namespace
  base_domain      = var.base_domain
  target_revision  = var.target_revision
  cluster_issuer   = var.cluster_issuer
  namespace        = var.namespace
  dependency_ids   = var.dependency_ids

  app_autosync = var.app_autosync
  app_skip_crds = var.app_skip_crds

  metrics_archives = var.metrics_archives
  prometheus       = var.prometheus
  alertmanager     = var.alertmanager
  grafana          = var.grafana

  helm_values = concat(local.helm_values, var.helm_values)
}
