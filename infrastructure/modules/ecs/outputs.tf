output "public_ip" {
  value = aws_instance.my_public.*.public_ip
}
