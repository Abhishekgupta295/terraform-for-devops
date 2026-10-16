resource "aws_dynamodb_table" "my-dynamodb-table" {
  name           = "${var.env}-${var.my_dynamodb_table}-${count.index + 1}"
  count          = var.dynamodb_table_count
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"  # it is like unique primary key

  attribute {
    name = "LockID"  # Attribute is like column of table 
    type = "S"
  }

  tags = {
    Environment = var.env
  }
}