resource "google_compute_disk" "prometheus-disk" {
  name  = "${var.deployment_name}-disk"
  type  = "pd-standard"
  zone  = "${var.gcp_zone}"
  size  = "20"
  image = "${var.disk_image}"
}

resource "google_compute_instance" "prometheus-server" {
  name         = "${var.deployment_name}-server"
  machine_type = "${var.machine_type}"
  zone         = "${var.gcp_zone}"

  tags = "${var.server_tags}"

  boot_disk {
    source      = "${var.deployment_name}-disk"
    auto_delete = false
  }

  network_interface {
    subnetwork = "${var.gcp_subnetwork}"
  }

  service_account {
    scopes = "${var.server_scopes}"
  }
}

resource "google_compute_firewall" "prometheus-server-fw-9090" {
  count   = "${var.shared_vpc == 0 ? 1 : 0}"
  name    = "${var.deployment_name}-server-9090"
  network = "${var.gcp_network}"

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  source_ranges = "${var.server_source_ranges}"
  source_tags   = "${var.server_source_tags}"
}

resource "google_compute_firewall" "prometheus-node-exporter-fw-9100" {
  count   = "${var.shared_vpc == 0 ? 1 : 0}"
  name    = "${var.deployment_name}-node-exporter-9100"
  project = "${var.gcp_project}"
  network = "${var.gcp_network}"

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }

  source_ranges = "${var.node_exporter_ranges}"
  source_tags   = "${var.node_exporter_tags}"
}

resource "google_compute_firewall" "prometheus-server-fw-9090" {
  count   = "${var.shared_vpc == 1 ? 1 : 0}"
  name    = "${var.deployment_name}-server-9090"
  network = "${var.gcp_network}"
  project = "${var.host_project}"

  allow {
    protocol = "tcp"
    ports    = ["9090"]
  }

  source_ranges = "${var.server_source_ranges}"
  source_tags   = "${var.server_source_tags}"
}

resource "google_compute_firewall" "prometheus-node-exporter-fw-9100" {
  count   = "${var.shared_vpc == 1 ? 1 : 0}"
  name    = "${var.deployment_name}-node-exporter-9100"
  project = "${var.gcp_project}"
  network = "${var.gcp_network}"
  project = "${var.host_project}"

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }

  source_ranges = "${var.node_exporter_ranges}"
  source_tags   = "${var.node_exporter_tags}"
}
