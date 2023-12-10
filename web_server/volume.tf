resource "hcloud_volume" "robocik_volume" {
    name = "robocik-volume-1"
    size = var.disk_size
    location = var.location
    format = "xfs"
}

resource "hcloud_volume_attachment" "robocik_volume_attachement" {
    volume_id = hcloud_volume.robocik_volume.id
    server_id = hcloud_server.robocik_server.id
    automount = true
}