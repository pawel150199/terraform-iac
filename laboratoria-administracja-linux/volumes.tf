resource "hcloud_volume" "lab_volume" {
    name = "lab-volume-1"
    size = var.disk_size
    location = var.location
    format = "xfs"
}

resource "hcloud_volume_attachment" "lab_volume_attachement" {
    volume_id = hcloud_volume.lab_volume.id
    server_id = hcloud_server.lab_server.id
    automount = true
}