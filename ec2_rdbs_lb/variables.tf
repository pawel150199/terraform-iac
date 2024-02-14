data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnets" "default_subnet" {
    filter {
        name   = "vpc-id"
        values = [data.aws_vpc.default_vpc.id]
    }
}

variable "aws_instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t2.micro"
}

variable "region" {
    description = "Region of created resource"
    type        = string
    default     = "eu-central-1"
}

variable "db_instance_allocated_storage" {
    description = "Allocated storage for DB instance"
    type        = number
    default     = 20
}

variable "db_instance_storage_type" {
    description = "Storage type for DB instance"
    type        = string
    default     = "standard"
}

variable "db_instance_engine" {
    description = "Engine for DB instance"
    type        = string
    default     = "postgres"
}

variable "db_instance_engine_version" {
    description = "Engine version for DB instance"
    type        = string
    default     = "12.15"
}

variable "db_instance_instance_class" {
    description = "Instance class for DB instance"
    type        = string
    default     = "db.t2.micro"
}

variable "db_instance_username" {
    description = "Username for DB instance"
    type        = string
    default     = "foo"
    sensitive  = true
}

variable "db_instance_password" {
    description = "Password for DB instance"
    type        = string
    default     = "foobarbaz"
    sensitive   = true
}

variable "db_instance_skip_final_snapshot" {
    description = "Skpi final version for DB instance"
    type        = bool
    default     = true
}