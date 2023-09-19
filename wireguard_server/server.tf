resource "hcloud_server" "wg_server" {
    name = "wg-server-1"
    image = var.os_type
    server_type = var.server_type
    location = var.location
    ssh_keys = [hcloud_ssh_key.default.id]
    labels = {
        type = "wg_server"
    }
    user_data = file("user_data.yml")
}