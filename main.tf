
/*O bloco provider serve para eu especificar o provider que eu quero usar
por exemplo, estou utilizando provider aws (arquivo descritivo)
nisso ele ta se comunicando a aws o que eu quero usar, a region e a version*/
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "west-2"
  /*O alias serve para eu utilizar multiplas configuraçoes de providers*/
  region = "us-west-2"
}

/*O bloco terraform não tem tipo*/
terraform {
  backend "s3" {
    #depois trocar o bucket para o meu
    bucket = "descomplicando-terraform-gomex-tfstates" /* todo esse bloco terraform serve para colocar o state no bucket*/
    /*O key vai ser o nome do arquivo de estado(state)*/
    key = "terraform-test.tfstate"
    region = "us-east-1"
  }
}

/*A parti que o projeto cresce, posso criar arquivos para cada "bloco
como providers.tf,backend.tf e o main.tf etc"*/

/*Apos o terraform init que vai inicializar o processo, vai dar erro pois necessida da AWS_ACCESS_KEY
e a AWS_SECRET_ACCESS_KEY para ter a inicalização do bucket s3
(AWS_SECRET_ACCESS_KEY TEM QUE MANTER SEGURA E NUNCAR MANDAR PARA O REPOSITORIO ) */

/*pode ser considerado uma boa pratica dependendo da situação utilizar o terraform init -upgrade 
para atualizar sempres os plugins(provider)*/

/*Apos o comando terraform plan, ele nao garante 100% do que voce viu, realmente vai acontecer por isso
pode ser interesante utilizar o terraform plan -out pois ele vai implantar 100% do que voce viu no init */

/*Apois isso, pode utilizar o terraform apply (nome do arquivo)*/