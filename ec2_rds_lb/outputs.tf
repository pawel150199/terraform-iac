output "instance_1_ip_address" {
    description = "Instance 1 IP address"
    value = aws_instance.instance_1.public_ip
}

output "instance_2_ip_address" {
    description = "Instance 2 IP address"
    value = aws_instance.instance_2.public_ip
}

output "db_instance_port" {
    description = "DB instance port"
    value = aws_db_instance.db_instance.port
}