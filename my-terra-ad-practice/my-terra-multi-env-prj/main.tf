locals {
    environments = {
        dev = {
            ec2_instance_count = 2
            bucket_count = 1
            table_count = 1
        }

        stg = {
            ec2_instance_count = 3
            bucket_count = 1
            table_count = 1
        }

        prd = {
            ec2_instance_count = 4
            bucket_count = 1
            table_count = 2
        }
        
}
}

module "ec2"{
    source = "./Modules/EC2"
    env = terraform.workspace # working stage(dev, stg, prd) will be assigned during runtime
    ec2_instance_count = local.environments[terraform.workspace].ec2_instance_count

} 

module "s3"{
    source = "./Modules/S3"
    env = terraform.workspace # working stage(dev, stg, prd) will be assigned during runtime
    s3_bucket_count = local.environments[terraform.workspace].bucket_count

} 

module "dynamodb"{
    source = "./Modules/DynamoDB"
    env = terraform.workspace # working stage(dev, stg, prd) will be assigned during runtime
    dynamodb_table_count = local.environments[terraform.workspace].table_count

} 