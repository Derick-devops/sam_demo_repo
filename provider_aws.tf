terraform { 
required_providers { 
aws = { 
source = "hashicorp/aws" 
version = "~> 5.0" 
} 
} 
# Remote state backend in S3 
backend "s3" { 
bucket = "derick-terraform-state-bucket"   
key = "terraform.tfstate"           
region = "ap-northeast-2" 
profile = "myprofile"
encrypt = true 
} 
} 
provider "aws" { 
region = "ap-northeast-2" 
} 