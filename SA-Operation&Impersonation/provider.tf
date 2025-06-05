



terraform {
  required_version = ">= 0.13"

  required_providers {
    google = {
    }

  }
}
provider "google" {
  alias                 = "service"
  project               = var.project_id
  region                = var.region
  user_project_override = true
  billing_project       = var.project_id
}