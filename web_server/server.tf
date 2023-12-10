resource "hcloud_server" "robocik_server" {
    name = "robocik-server-1"
    image = var.os_type
    server_type = var.server_type
    location = var.location
    ssh_keys = [hcloud_ssh_key.default.id]
    labels = {
        type = "robocik_server"
    }
}