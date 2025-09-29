variable "vpc_cidr" { 
default = "10.0.0.0/16" 
} 
variable "subnet_cidr" { 
default = "10.0.1.0/24" 
} 
variable "instance_type" { 
default = "t3.micro" 
} 
variable "key_name" { 
description = "EC2 Key Pair name" 
type        = string 
default  = "dkay-key" 
# Change to your bucket name # Just the file name 
# Replace with your desired key pair name 
}