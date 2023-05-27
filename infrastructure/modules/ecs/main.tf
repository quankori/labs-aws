resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo"
}

resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "my-ecs-cluster"
}
