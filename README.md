# Prometheus on GCP Terraform Module

This is a bare-bones Terraform module for deploying [Prometheus](https://prometheus.io/).
It creates the image, a disk for persistent storage of data and two firewall rules. One rule allows
traffic to the Prometheus service and the other configures a rule allowing communication from
the Prometheus server to instances running [node exporter](https://github.com/prometheus/node_exporter).

## To Do
- [ ] Determine and provide useful outputs.
- [ ] Provide example Packer build file for Prometheus image.

## Example Usage
```
module "prometheus-deployment" {
    source = "git@github.com:the-control-group/terraform-google-prometheus"
    gcp_project = "infrastructure"
    gcp_zone = "us-east1-b"
    gcp_network = "tcg-infra"
    gcp_subnetwork = "tcg-infra-private"
    disk_image = "prometheus"
    server_source_ranges = ["0.0.0.0/0"]
    node_exporter_tags = ["prometheus-server"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| deployment_name | Name to identify the prometheus deployement. | string | `prometheus` | no |
| disk_image | Disk image to use when deploying prometheus. This module assumes that you have already deployed an image that has prometheus installed and configured. | string | - | yes |
| gcp_network | Network that the firewall rules will be associated with. | string | - | yes |
| gcp_project | The project that prometheus will be deployed to. | string | - | yes |
| gcp_subnetwork | Subnetwork to attach the instance to. | string | - | yes |
| gcp_zone | The host zone where prometheus will be deployed to. | string | - | yes |
| host_project | Host project ID if using a shared vpc. | string | `` | no |
| machine_type | Instance size to deploy prometheus on to. | string | `g1-small` | no |
| node_exporter_ranges | The source ranges allowed to access to communicate with the node exporter. | list | `<list>` | no |
| node_exporter_tags | The source tags allowed to access to communicate with the node exporter. | list | `<list>` | no |
| server_scopes | The instance's permissions to different GCP services. | list | `<list>` | no |
| server_source_ranges | The source ranges allowed access to communicate with the prometheus server. | list | `<list>` | no |
| server_source_tags | The source ranges allowed access to communicate with the prometheus server. | list | `<list>` | no |
| server_tags | Network tags to identify the server. | list | `<list>` | no |
| shared_vpc | Whether or not Prometheus will be deployed onto a shared vpc. | string | `false` | no |
