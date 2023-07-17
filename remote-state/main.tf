terraform {
  backend "s3" {
    bucket = "bucketforterraforme"
    key    = "sample/terraform.tfstate"
    region = "us-east-1"
  }
}
