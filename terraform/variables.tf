variable "gcp_project_id" {
  type     = string
  nullable = false
}

variable "region" {
  type     = string
  nullable = false
  default  = "asia-northeast1"
}