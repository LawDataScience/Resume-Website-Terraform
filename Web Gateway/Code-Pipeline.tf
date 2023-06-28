/*
variable "bucket_name" {
  default     = "tfcp"
  description = "terraform code_pipeline"
}

variable "code_pipeline_artifact_bucket" {
  default     = "tfcp_artifact"
  description = "terraform code_pipeline artifact bucket"
}

variable "tfcp_repo" {
  default     = "tfcp"
  description = "terraform code_pipeline repository"
}

variable "code_pipeline_role" {
  default     = "TF_Code_Pipeline_Role"
  description = "role of the terraform code_pipeline"
}

variable "code_build_role" {
  default     = "TF_Code_Build_Role"
  description = "role of the terraform code_build"
}

resource "aws_s3_bucket" "code_pipeline_artifact_bucket" {
    bucket = var.code_pipeline_artifact_bucket
    acl = "private"
}

resource "aws_s3_bucket" "code_pipeline_bucket" {
    bucket = var.bucket_name
    policy = <<POLICY
    {
        "Version": "2012-10-17"
        "Statement": [
            "Sid": "no_name",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3.GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        ]
    }
    POLICY
}

resource "aws_s3_bucket_website_configuration" "website"{
    bucket = aws_s3_bucket.code_pipeline_bucket.bucket
    index_document{
        suffix = "index.html"
    }
    error_document{
        key = "index.html"
    }
    routing_rule{
        condition{
            key_prefix_equals = "/"
        }
        redirect{
            replace_key_prefix_with = "/index.html"
        }
    }
}

resource "aws_codecommit_repository" "example_repo"{
    repository_name = var.repo_name

}

resource "aws_iam_role" "code_pipeline_role"{
    name = var.code_pipeline_role
    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17"
        "Statement": [
            {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "code_pipeline.amazonaws.com"
            }
        }
    ]
    }
    POLICY
}

resource "aws_iam_role" "code_build_role"{
    name = var.code_build_role
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17"
        "Statement": [
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole",
    }
    EOF
}

resource "aws_iam_role_policy" "code_build_policy"{
    role = aws_iam_role.code_build_role.name
    policy = <<POLICY
    {
        "Version": "2012-10-17"
        "Statement": [
            {
                "Effect": "Allow",
                "Resource": ["*"],
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ec2:CreateNetworkInterface",
                    "ec2:DescribeOhcpOptions",
                    "ec2:DescribeNetworkInterfaces",
                    "ec2:DeleteNetworkInterface",
                    "ec2:DescribeSubnets",
                    "ec2:DescribeSecurityGroups",
                    "ec2:DescribeVpcs"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow"
                "Action": [
                    "ec2:CreateNetworkInterfacePermission",
                    "ec2:DeleteNetworkInterfacePermission"
                ],
                "Resource": [
                    "arn:aws:ec2:us-east-1:826720015447:network-interface/*"
                ],
                "Condition":{
                    "StringEquals":{
                        "ec2:Subnet": [
                            "arn:aws:ec2:us-east-1:826720015447:subnet/subnet-077a20bda885952c3"
                        ],
                        "ec2:AuthorizedService": "codebuild.amazonaws.com"
                    }
                }
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": [
                    "${aws_s3_bucket.code_pipeline_bucket.arn}",
                    "${aws_s3_bucket.code_pipeline_bucket.arn}/*",
                    "${aws_s3_bucket.code_pipeline_artifact_bucket.arn}",
                    "${aws_s3_bucket.code_pipeline_artifact_bucket.arn}/*"
                ]
            }
        ]
    }
    POLICY
}
*/
