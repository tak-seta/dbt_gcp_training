variable "gcp_project_id" {
  type     = string
  nullable = false
}

variable "region" {
  type     = string
  nullable = false
  default  = "asia-northeast1"
}

variable "container_image" {
  description = "docker container image"
  type        = string
  default     = ""
}
