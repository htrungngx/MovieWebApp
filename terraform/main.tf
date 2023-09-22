resource "google_compute_instance" "default" {
  project                   = google_project.my_project.project_id
  name                      = "devops-app-vm"
  machine_type              = "e2-small"
  zone                      = "europe-north1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }
  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id

    access_config {
      nat_ip = google_compute_address.dev_static_ip.address
    }
  }

  tags = ["web"]

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }

}

resource "google_compute_instance" "jenkins" {
  project                   = google_project.my_project.project_id
  name                      = "devops-jenkins-vm"
  machine_type              = "e2-medium"
  zone                      = "europe-north1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_jenkins_static_ip.address
    }
  }
  tags = ["jenkins"]

}



resource "google_compute_instance" "sonarqube" {
  project                   = google_project.my_project.project_id
  name                      = "devops-sonarqube-vm"
  machine_type              = "e2-medium"
  zone                      = "europe-north1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_sonarqube_static_ip.address
    }
  }

  tags = ["sonarqube"]

}

/***resource "google_compute_instance" "monitor" {
  project                   = google_project.my_project.project_id
  name                      = "devops-monitoring-vm"
  machine_type              = "e2-small"
  zone                      = "europe-north1-a"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork         = google_compute_network.network.name
    subnetwork_project = google_project.my_project.project_id


    access_config {
      nat_ip = google_compute_address.dev_monitor_static_ip.address
    }
  }

  tags = ["monitor"]

}**/


