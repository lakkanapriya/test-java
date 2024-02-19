terraform {
  backend "s3" {
    bucket = "tf-states"
    key    = "tdd"
    region = "us-east-1"
  }
}
