terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        /*o source trabalha com 3 parametros 
        hostname,namespace,type/ informa ao Terraform o caminho ou endereço de onde baixar e carregar
        os arquivos de configuração do módulo.*/
        version = "~> 3.0"
    }
  }
}