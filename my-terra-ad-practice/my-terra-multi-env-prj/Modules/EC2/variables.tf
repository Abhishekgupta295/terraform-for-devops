variable "ec2_instance_name" {
    description = "EC2 instance name"
    type        = string
    default     = "abhi-terra-auto-server"
}

variable "ec2_volume_size" {
    description = "EC2 instance volume size"
    type        = number
    default     = 10
}

variable "ec2_instance_count" {
    description = "EC2 instance count"
    type        = number

}

variable "ec2_instance_type" {
    description = "EC2 instance type"
    type        = string
    default     = "t3.micro"
}

variable "ec2_instance_state" {
    description = "EC2 instance state"
    type        = string
    default     = "running"
}

variable "ec2_ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
    default     = "ami-0b6d9d3d33ba97d99"
}

variable "ec2_key_name" {
    description = "Key name for the EC2 instance"
    type        = string
    default     = "terra-automate-key"
}

variable "ec2_root_volume_size" {
    description = "Root volume size for the EC2 instance"
    type        = number
    default     = 10
}

variable "ec2_root_volume_type" {
    description = "Root volume type for the EC2 instance"
    type        = string
    default     = "gp3"
}

variable "env" {
  
    description = "Environment in which we are working"
    type        = string
    default     = "env"
}