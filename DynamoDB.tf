
# DynamoDB Implementation
resource "aws_dynamodb_table" "demo_dynamodb_table"{
    name = "DynamoDB-Terraform"
    billing_mode = "PROVISIONED"
    read_capacity = 5
    write_capacity = 5
    hash_key = "UserId"
    range_key = "Name"

    attribute {
        name = "UserId"
        type = "S"
    }
    tags = {
        Name = "dynamodb_table"
        Environment = "Training"
    } 
    global_secondary_index {
        name = "UserTitleIndex"
        hash_key = "UserId"
        range_key = "Name"
        write_capacity = 10
        read_capacity = 10
        projection_type = "INCLUDE"
        non_key_attributes = ["UserId"]
    } 
    attribute {
        name = "Name"
        type = "S"
    }
}