



variable "student_id_email" {
  type        = string
}


variable "project_id" {
  type        = string
}


variable "service_account_name" {
  type        = string
}

variable "vpc_network_name" {
  type        = string
}

variable "vm_name" {
  type        = string
}

variable "zone" {
  type        = string
}

variable "region" {
  type        = string
}



variable "subnet" {
  type        = string
}





/*

variable "vertex_insance_owner" {
   type        = list(string)
  description = "Vertex workbench instance owners"
    default     = ["admin@manishkgaur.altostrat.com"]
}




variable "network_region" {
  type        = string
  description = "Primary network region"
  default     = "us-central1"
}


variable "vpc_dmz_subnetwork" {
  type        = string
  description = "Subnet range for DMZ subnet"
  default     = "10.10.0.0/24"
}



variable "roles" {
  type        = list(string)
  description = "The roles that will be granted to the service account."
  default     = ["roles/aiplatform.user", "roles/modelarmor.admin", "roles/iam.serviceAccountUser", "roles/storage.objectUser", "roles/serviceusage.serviceUsageConsumer"]
}


variable "ma_dlp_roles" {
  type        = list(string)
  description = "Grant the Model Armor Service Account DLP privileges"
  default     = ["roles/dlp.user", "roles/dlp.reader"]
}

*/