output "lb_ipv4" {
    description = "Load balancer IP address"
    value = hcloud_load_balancer.web_lb.ipv4
}

output "web_server_status" {
    description = "Web server status"
    value = {
        for server in hcloud_server.web : 
        server.name => server.status
    }
}

output "web_server_ips" {
    description = "Web servers IP addresses"
    value = {
        for server in hcloud_server.web :
        server.name => server.ipv4_address
    }
}