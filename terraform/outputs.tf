output "ec2_public_ip" {
  value = aws_instance.docker_host.public_ip
}

output "elastic_ip" {
  value = aws_eip.web_eip.public_ip
}
