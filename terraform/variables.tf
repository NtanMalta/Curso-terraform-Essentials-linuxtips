/*O nome na variable pode ser qualquer um
menos, source,version,providers,count,for_each,lifecyle
depends_on,loals, pois são meta-arguments*/

variable "image_id" {
  default = "ami-12345678"
  /*Pode ussar o default para definir um valor que será aplicado automaticamente caso
  nenhum outro valor seja fornecido pelo o usuario*/
  
  type = string
  /*type constraints*/
  description = "the id of the machine image (AMI) to use for the server"
  
sensitive = true
/*A variavel sensitive serve para  que qualque dado sensivel não apareça no console*/

  /*Esa parte de validation serve para testar se as variaveis atendem a regras esperadas
  antes de criar a infraestrutu*/
  validation {
    condition = length(var.image_id) > 4 && substr(image_id,0, 1) == "ami-"
    /*length para verificar o tamanho da variavel*/
    error_message = "the image_id must be a valid AMI id, starting with \"ami-\"."
  }

}

/*O type constraints é a idea de voce forçar o valor que passou pelo o default
ou pelo proprio variable, dizer qual tipo desse valor*/

/*Tambem é interessante a utilização do description que é a descrição do que aquele bloco
vai dizer*/