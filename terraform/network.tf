resource "google_compute_network" "network" {
  name    = "devops-network"
  project = google_project.my_project.project_id
}

resource "google_compute_firewall" "http" {
  name    = "devops-firewall"
  network = google_compute_network.network.name
  project = google_project.my_project.project_id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22", "3000", "9000", "9100"]
  }

  target_tags   = ["web", "jenkins", "monitor", "sonarqube"]
  source_ranges = ["0.0.0.0/0"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

}


