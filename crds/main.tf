data "helm_template" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  namespace  = "default"
  repository = "https://prometheus-community.github.io/helm-charts"

  chart   = "kube-prometheus-stack"
  version = var.chart_version

  include_crds = "true"
}

locals {
  kps_crds = merge([
    for key, value in data.helm_template.kube_prometheus_stack.manifests : merge([
      for crd_value in split("\n---\n", value) : {
        yamldecode(crd_value).metadata.name = yamldecode(crd_value)
      }
      if length(regexall("kind: CustomResourceDefinition", value)) > 0
    ]...)
  ]...)
}

resource "kubernetes_manifest" "kube_prometheus_stack" {
  for_each = local.kps_crds
  manifest = merge(each.value, { "metadata" = { for k, v in each.value.metadata : k => v if k != "creationTimestamp" } })

  field_manager {
    name            = ".spec.versions"
    force_conflicts = true
  }
}
