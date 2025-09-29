output "vpc_id" { 
value = aws_vpc.main.id 
} 
output "public_subnet_id" { 
value = aws_subnet.public.id 
} 
output "instance_public_ip" { 
value = aws_instance.my_ec2.public_ip 
} 
output "private_key_pem" { 
value     = tls_private_key.my_key.private_key_pem 
sensitive = true 
} 
