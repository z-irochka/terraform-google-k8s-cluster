variable "google_service_account_id" {
  type      = string
  sensitive = true
}

variable "google_project_id" {
  type      = string
  sensitive = true
}

variable "k8s_cluster_name" {
  type = string
}

variable "cluster_location" {
  type    = string
  default = "us-central1-a"
}

variable "k8s_node_pool_name" {
  type    = string
  default = "default"
}

variable "k8s_node_pool_size" {
  type    = number
  default = 1
}

variable "k8s_node_pool_machine_type" {
  default = "e2-standard-2"
}

variable "k8s_node_pool_disk_size" {
  type    = number
  default = 30
}

variable "k8s_node_pool_disk_type" {
  type    = string
  default = "pd-standard"
}
