output "server_ipv4" {
    description = "Server IP"
    value = hcloud_server.lab_server.ipv4_address
}