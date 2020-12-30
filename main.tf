#
provider "google" {
  credentials = file(var.credentials_file)
  project = var.project
  region  = var.my_region
  zone    = var.my_zone
}

resource "google_compute_network" "vpc_network" {
  name = var.my_network
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnetwork" {
  name          = "private-subnetwork"
  ip_cidr_range = var.ip_cidr_range_private
  region        = var.my_region
  network       = google_compute_network.vpc_network.id
  depends_on = [google_compute_network.vpc_network]
}

