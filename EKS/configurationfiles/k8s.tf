provider "kubernetes" {
  config_context_cluster = "my-eks-cluster"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-namespace"
  }
}
