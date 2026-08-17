module "servers" {
  source = "./servers"
  servers = 2
  

  /*Esse providers dentro do modulo é uma forma de uilizar o providers de forma explicita
  dessa forma ele vai criar nessa regiao*/  
  providers = {
    aws = "west-2"
  }

  /*Esse servers = 2, serve para criar quantas instancias que voce quiser(criando 2 agora)
  com aquelas mesmas configuraçoes no bloco resource */
}

/*esse servers = 2 é o inputs do modulo filho, se nao for o version,providers,source*/

/*toda vez que eu criar um modul, preciso usar o comando terraform init para inicializar*/

output "ip_address" {
  value = module.servers.ip_address

  /*esse output foi pego no modulo filho (servers/output.tf)*/
}


/*Esse novo bloco resource é outro tipo de recurso que pode ser utilizado*/
resource "aws_route53_record" "server" {
  /*esse aws_route53_record é um serviço aws para gerenciamento de zona de DNS*/
  /*sendo assim vai criar um registro*/
  zone_id = "Z020416930HK"
  name = "server"
  type = "A"
  ttl = "300"
  records = [module.servers.ip_address[0]]
}