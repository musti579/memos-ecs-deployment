terraform {
  backend "s3" {
    bucket       = "memos-ecs-tfstate-musti579"
    key          = "memos/terraform.tfstate"
    region       = "eu-north-1"
    use_lockfile = true
  }
}
