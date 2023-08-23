######## Creating Ecr Repository ########
resource "aws_ecr_repository" "medstick_prodecrrepo" {
  for_each             = toset(var.ecrname)
  name                 = each.key
  image_tag_mutability = var.immutable_ecr_repositories ? "IMMUTABLE" : "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = var.encryption_type
  }
  tags = local.terratag_added_main
}

resource "time_sleep" "wait_300_seconds" {
  depends_on = [aws_ecr_repository.medstick_prodecrrepo]

  create_duration = var.create_duration
}

######## Creating Ecr Lifecycle Policy ########
resource "aws_ecr_lifecycle_policy" "medstick_prodecrpolicy" {
  for_each   = toset(var.ecrname)
  repository = each.key

  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  }
  EOF
  depends_on = [time_sleep.wait_300_seconds]
}


######## Creating Ecr Repository Policy ########
resource "aws_ecr_repository_policy" "medstick_prodrepopolicy" {
  for_each   = toset(var.ecrname)
  repository = each.key
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "Set the permission for ECR",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
  depends_on = [time_sleep.wait_300_seconds]
}


locals {
  terratag_added_main = { "Project" = "Medstick", "Project_Manager" = "Vrusha", "Purpose" = "Prod", "created_by" = "priyanka.pradhan@nineleaps.com", "environment_id" = "prod" }
}

