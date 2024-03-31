resource "aws_dynamodb_table" "comments-demo" {
  name           = "comments-${var.env}"
  billing_mode   = "PROVISIONED"
  read_capacity  = "5"
  write_capacity = "5"
  attribute {
    name = "commentId"
    type = "S"
  }

  # no need to define every attribute
  #   attribute {
  #     name = "comment"
  #     type = "S"
  #   }

  #   attribute {
  #     name = "author"
  #     type = "S"
  #   }

  hash_key = "commentId"
}


resource "aws_ecr_repository" "comments-demo" {
  name = "comments/${var.env}/code-images"
}

resource "aws_ecr_repository_policy" "comments" {
  repository = aws_ecr_repository.comments.name

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "ecr:*"
      ]
    }
  ]
}
EOF
}