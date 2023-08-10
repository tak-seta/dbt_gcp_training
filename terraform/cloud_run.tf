resource "google_cloud_run_v2_job" "default" {
  name     = "hello-dbt"
  location = var.region
  template {
    template {
      containers {
        image = var.container_image
      }
      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
    }
  }
}
