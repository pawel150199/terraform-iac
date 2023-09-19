resource "hcloud_volume" "wg_volume" {
    name = "wg-server-volume-1"
    size = var.disk_size
    location = var.location
    format = "xfs"
}

resource "hcloud_volume_attachment" "wg_volume_attachement" {
    volume_id = hcloud_volume.wg_volume.id
    server_id = hcloud_server.wg_server.id
    automount = true
}