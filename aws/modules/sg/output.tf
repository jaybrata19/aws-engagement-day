output "security_group_ids" {
  description = "IDs of the security groups"
  value = {
    allow_ssh  = aws_security_group.allow_ssh.id
    allow_http = aws_security_group.allow_http.id
  }
}
