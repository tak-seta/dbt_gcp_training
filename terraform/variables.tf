variable "gcp_project_id" {
  type     = string
  nullable = false
}

variable "region" {
  type     = string
  nullable = false
  default  = "asia-northeast1"
}

variable "data_source_bucket_name" {
  type        = string
  description = "イベントの元データとなるcsvを格納するバケット"
}

variable "container_image" {
  description = "docker container image"
  type        = string
  default     = ""
}
