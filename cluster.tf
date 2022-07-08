data "google_service_account" "k8s_service_account" {
  account_id = var.google_service_account_id
  project    = var.google_project_id
}

resource "google_container_cluster" "k8s_cluster" {
  name     = var.k8s_cluster_name
  location = var.cluster_location

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "k8s_main_node_pool" {
  name       = var.k8s_node_pool_name == "default" ? "${var.k8s_cluster_name}-node-pool" : var.k8s_node_pool_name
  cluster    = google_container_cluster.k8s_cluster.name
  location   = var.cluster_location
  node_count = var.k8s_node_pool_size
  autoscaling {
    max_node_count = 1
    min_node_count = var.k8s_node_pool_size
  }
  node_config {
    preemptible  = false
    machine_type = var.k8s_node_pool_machine_type
    disk_size_gb = var.k8s_node_pool_disk_size
    disk_type    = var.k8s_node_pool_disk_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.k8s_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}