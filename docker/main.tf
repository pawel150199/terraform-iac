terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = "~> 3.0.2"
        }
    }
}
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
    name = "nginx"
    keep_locally = true
}

resource "docker_container" "nginx" {
    image = docker_image.nginx.id
    name = "docker_terraform"

    tty = true
    stdin_open = true

    ports {
        internal = 80
        external = 8080
    }
}