module "kubernetes_cluster" {
  source = "../kubernetes"

  name = var.kubernetes_cluster_name
  region = "nyc1"
  kubernetes_version = "1.28.14-do.1"

  kubeconfig_out_path = "${path.root}/../../kubernetes/kubeconfig.yaml"

  primary_node_pool = {
    name = "worker-pool-dedicated-cpu-b"
    size = "c-4"
    node_count = {
      count = 1
    }
  }

  maintenance = {
    day = "sunday"
    start_time = "04:00" # Midnight EST
  }
}
