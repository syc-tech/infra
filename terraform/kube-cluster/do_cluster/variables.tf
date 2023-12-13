variable "cluster_version" {
  type = string
}

variable "worker_count" {
  type = number // No longer used, maybe replace with min nodes and max nodes? 
}

variable "worker_size" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_region" {
  type = string
}

variable "do_token" {
  type = string
}