variable "my_dynamodb_table" {
    description = "dynamodb table name"
    type        = string
    default     = "abhi295-remote-table-project"
}


variable "env" {
  
    description = "Environment in which we are working"
    type        = string
    default     = "env"
}

variable "dynamodb_table_count" {
    description = "EC2 instance count"
    type        = number

}