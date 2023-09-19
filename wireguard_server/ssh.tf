resource "hcloud_ssh_key" "default" {
    name = "hetzner"
    public_key = file("~/.ssh/hetzner.pub")
}