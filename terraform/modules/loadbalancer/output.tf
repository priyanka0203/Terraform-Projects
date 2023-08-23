output "secgrpid" {
  value = [aws_security_group.medstick_prodlbsg.id, ]
}
output "lbid" {
  value = [aws_elb.medstick_prodelb.id, ]
}
