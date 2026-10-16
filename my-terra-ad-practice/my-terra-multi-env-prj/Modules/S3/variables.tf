variable "s3_bucket_name" {
    description = "EC2 instance name"
    type        = string
    default     = "abhi-terra-bucket"
}


variable "env" {
  
    description = "Environment in which we are working"
    type        = string
    default     = "env"
}

variable "s3_bucket_count" {
    description = "EC2 instance count"
    type        = number

}