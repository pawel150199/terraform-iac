data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_s3_bucket" "tf_state" {
    bucket        = "tf-state"
    force_destroy = true

    tags = {
        Name        = "Terraform state"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_instance" "instance_1" {
    ami             = "ami-0134dde2b68fe1b07"
    instance_type   = var.aws_instance_type
    security_groups = [aws_security_group.instances.name]
    user_data       = <<-EOF
            #!/bin/bash
            echo "Hello World!" > index.html
            python3 -m http.server 8080&
            EOF
}

resource "aws_instance" "instance_2" {
    ami             = "ami-0134dde2b68fe1b07"
    instance_type   = var.aws_instance_type
    security_groups = [aws_security_group.instances.name]
    user_data       = <<-EOF
            #!/bin/bash
            echo "Hello World 2!" > index.html
            python3 -m http.server 8080&
            EOF
}

resource "aws_security_group" "instances" {
    name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
    type                = "ingress"
    security_group_id   = aws_security_group.instances.id

    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.load_balancer.arn

    port = 80

    protocol = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
          content_type = "text/plain"
          message_body = "404: Page not found!"
          status_code = 404
        }
    }
}

resource "aws_lb_target_group" "instances" {
    name        = "example-target-group"
    port        = 8080
    protocol    = "HTTP"
    vpc_id      = data.aws_vpc.default_vpc.id

    health_check {
        path                    = "/health"
        protocol                = "HTTP"
        matcher                 = "200"
        interval                = 15
        timeout                 = 3
        healthy_threshold       = 2
        unhealthy_threshold     = 2
    }
}

resource "aws_lb_target_group_attachment" "instance_1" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id = aws_instance.instance_1.id
    port = 8080
}

resource "aws_lb_target_group_attachment" "instance_2" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id = aws_instance.instance_2.id
    port = 8080
}

resource "aws_lb_listener_rule" "instances" {
    listener_arn = aws_lb_listener.http.arn
    priority = 100

    condition {
      path_pattern {
          values = ["*"]
      }
    }

    action {
      type      = "forward"
      target_group_arn = aws_lb_target_group.instances.arn
    }
}

resource "aws_security_group" "alb" {
    name = "alb-security-group"
}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
    type                = "ingress"
    security_group_id   = aws_security_group.alb.id

    from_port     = 80
    to_port       = 80
    protocol      = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
    type                = "egress"
    security_group_id   = aws_security_group.alb.id

    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_lb" "load_balancer" {
    name                    = "web-app-lb"
    load_balancer_type      = "application"
    subnets                 = toset(data.aws_subnets.default_subnet.ids)
    security_groups         = [aws_security_group.alb.id]
}

resource "aws_route53_zone" "primary" {
    name = "harcownikapp.uk"
}

resource "aws_route53_record" "root" {
    zone_id     = aws_route53_zone.primary.zone_id
    name        = "harcownikapp.uk"
    type        = "A"

    alias {
        name                    =  aws_lb.load_balancer.dns_name
        zone_id                 =  aws_lb.load_balancer.zone_id
        evaluate_target_health =  true
    }
}

resource "aws_db_instance" "db_instance" {
    allocated_storage   = var.db_instance_allocated_storage
    storage_type        = var.db_instance_storage_type
    engine              = var.db_instance_engine
    engine_version      = var.db_instance_engine_version
    instance_class      = var.db_instance_instance_class
    username            = var.db_instance_username
    password            = var.db_instance_password
    skip_final_snapshot = var.db_instance_skip_final_snapshot
}