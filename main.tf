resource "google_compute_disk" "prometheus-disk" {
    name = "${var.deployment_name}-disk"
    type = "pd-standard"
    zone = "${var.gcp_zone}"
    size = "20"
    image = "${var.disk_image}"
}

resource "google_compute_instance" "prometheus-server" {
    name = "${var.deployment_name}-server"
    machine_type = "${var.machine_type}"
    zone = "${var.gcp_zone}"

    tags = "${var.server_tags}"

    boot_disk {
        source = "${var.deployment_name}-disk"
        auto_delete = false
    }

    network_interface {
        subnetwork = "${var.gcp_subnetwork}"
    }

    service_account {
            scopes = "${var.server_scopes}"
    }
}

module "prometheus-server-fw-9090" {
    source = "git@github.com:the-control-group/terraform-modules.git//gcp/network/firewall-allow-1"
    name = "${var.deployment_name}-server-9090"
    project = "${var.gcp_project}"
    network = "${var.gcp_network}"
    protocol = "tcp"
    ports = ["9090"]
    source_ranges = "${var.server_source_ranges}"
    source_tags = "${var.server_source_tags}"
}

module "prometheus-node-exporter-fw-9100" {
    source = "git@github.com:the-control-group/terraform-modules.git//gcp/network/firewall-allow-1"
    name = "${var.deployment_name}-node-exporter-9100"
    project = "${var.gcp_project}"
    network = "${var.gcp_network}"
    protocol = "tcp"
    ports = ["9100"]
    source_ranges = "${var.node_exporter_ranges}"
    source_tags = "${var.node_exporter_tags}"
}
