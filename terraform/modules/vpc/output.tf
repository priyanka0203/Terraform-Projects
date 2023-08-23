output "vpcid" {
  value = aws_vpc.medstick_prodvpc.id
}
output "subnetids" {
  value = [aws_subnet.medstick_prodsubnet.id, aws_subnet.medstick_prodsubnet1.id]
}
