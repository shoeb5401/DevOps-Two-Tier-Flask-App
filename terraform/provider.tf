terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.0"
      
    }
    tls = {
          source = "hashicorp/tls"
          version = "4.1.0"
        }
    local = {
              source = "hashicorp/local"
              version = "2.6.1"
            }
  }
  
}
provider "aws" {
  region = "ap-south-1"
  profile = "default"
  
}
