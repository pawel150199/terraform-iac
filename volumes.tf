resource "hcloud_volume" "web_servers_volume" {
    count = var.instances
    name = "web_servers_volume-${count.index}"
    size = var.disk_size
    location = var.location
    format = "xfs"
}

resource "hcloud_attachment" "web_servers_volume_attachement" {
    count = var.instances
    volume_id = hcloud_volume.web_servers_volume[count.index].id
    server_id = hcloud_server[count.index].web.id
    automount = true
}