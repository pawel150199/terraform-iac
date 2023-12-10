variable "hcloud_token" {
    #token = "<your-api-token>"   
}

variable "location" {
    default = "hel1"
}

variable "server_type" {
    default = "cx11"
}

variable "os_type" {
    default = "ubuntu-20.04"
}

variable "disk_size" {
    default = "10"
}

variable "network_zone" {
    default = "eu-central"
}

variable "ip_range" {
    default = "10.0.1.0/24"
}