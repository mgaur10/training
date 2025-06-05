



#Create the service Account for compute instances
resource "google_service_account" "srv_acc" {
  provider     = google.service
  project      = var.project_id
  account_id   = var.service_account_name
  display_name = var.service_account_name
  #depends_on = [
   # time_sleep.wait_enable_service_api_armor,
  #]
}


resource "google_project_iam_member" "srv_acc_project"   {
  project = var.project_id
  role    = "roles/compute.viewer"

  member = "serviceAccount:${google_service_account.srv_acc.email}"
  
}  


# VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  provider                = google-beta
  auto_create_subnetworks = false
  project                 = var.project_id
  #depends_on = [
   # google_project_organization_policy.external_ip_access,
    #time_sleep.wait_enable_service_api_armor,
  #]

}



# backend subnet
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnet
  provider      = google-beta
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id
  #depends_on = [
  #  google_compute_network.base_network,
  #]
}


# Enable SSH through IAP
resource "google_compute_firewall" "allow_iap_proxy" {
  name      = "allow-iap-proxy"
  network   = google_compute_network.vpc_network.self_link
  project   = var.project_id
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  depends_on = [
    google_compute_subnetwork.vpc_subnetwork,
  ]
}


resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = "n1-standard-2"
  zone         = var.zone
  project   = var.project_id
  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }


  metadata = {
    enable-oslogin = "TRUE"
  }
  metadata_startup_script = "sudo apt-get install jq  && curl --silent \"http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/\" -H \"Metadata-Flavor: Google\" | jq . "
  service_account {
    scopes = ["cloud-platform"]
    email  = google_service_account.srv_acc.email
  }
}