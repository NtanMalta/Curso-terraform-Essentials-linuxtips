
/*O bloco provider serve para eu especificar o provider que eu quero usar
por exemplo, estou utilizando provider aws (arquivo descritivo)
nisso ele ta se comunicando a aws o que eu quero usar, a region e a version*/
provider "aws" {
  region = "${terraform.workspace == "production" ? "us-east-1" : "us-east-2" }"
  /*colocar o workspace em duas regioes diferentes*/

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
    dynamodb_table = "terraform-state-lock-dynamo"
    /*state lock */
    /*O key vai ser o nome do arquivo de estado(state)*/
    key = "terraform-test.tfstate"
    region = "us-east-1"
    encrypt = true
    /*serve para eu proteger os dados do state junto com o .gitignore para nao mandar para o repositorio*/
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

/*O comando terraform state pull > nomedoarquivo.tfstate ele faz uma copia do state que ficar no bucket para o um
arquivo local*/

/*O Terraform já executa um refresh automático em memória por padrão antes de rodar 
comandos como terraform plan e terraform apply
sendo assim o comando terraform refresh é considerado obsoleto para operação usada para sincronizar o arquivo de estado (.tfstate)
do Terraform com o estado real dos recursos no provedor de nuvem (como AWS, Azure ou GCP). Ele consulta a API real para atualizar
o registro interno sem alterar a infraestrutura física. */

/*O comando terraform state list lista todos os recurso que o terraform esta gerenciando*/

/*O comando terraform state mv serve para renomear um recurso
EX.. terraform state mv(nome atual do recurso) (novo nome para o recurso)
se eu modificar o nome e nao modificar tambem no arquivo, o terraform vai destruir esse segundo arquivo*/

/*O comando terraform state rm serve para dizer ao Terraform para esquecer um recurso. 
Ele remove o item do seu arquivo de estado para que o Terraform
não tente mais gerenciá-lo, ele não destroi esse recurso e sim so para de utilizar ele .*/

/*O comando terraform import serve para importar infraestrutura existente
EX.. terraform import (nome da instancia).(qualquer nome) (e o ID da instancia)*/

/*Os workspaces no Terraform são como "ambientes paralelos" para o seu estado. Eles permitem que você gerencie
diferentes coleções de infraestrutura usando exatamente
o mesmo conjunto de arquivos de código*/

/*
workspaces é justamente permitir que você implante várias "instâncias" (ou cópias) da sua
infraestrutura usando o mesmo
bloco de configuração de backend no seu código.*/

/*mas se fizer um destroy ele literalmente vai destruir o backend*/

/*terraform workspace new dev (Cria um novo workspace chamado "dev" e muda para ele)

terraform workspace select prod (Muda para o workspace "prod")

terraform workspace list (Mostra todos os workspaces disponíveis)

terraform workspace show (Mostra em qual você está agora)*/