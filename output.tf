
/*Esse bloco output apos o final da execução do apply,
 ele vai mostrar esse value na tela / refencia / apontar para recurso*/
output "ip_address" {
    /*esse ip_address vai ser o nome do que foi criado apos o terraform apply*/
  value  = aws_instance.web.public_ip
  /*o aws_instance:tipo de recurso la no arquivo EC2.tf
  web:o nome do tipo */
}