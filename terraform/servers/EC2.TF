
/*O data vai olhar o provider que voce ta usando e vai buscar 
alguma informação que voce que   */

data "aws_ami" "ubuntu" {
    /*Ele vai procurar essa informação do aws_ami que voce que criou */
  most_recent = true

  filter {
    /*Literalmente um filtro para aquilo que estou buscando*/        
  name = "name"
  values = ["ubuntu/images/hvm-ssd/ubuntu-focal/20.04--amf64-server-*"]  /*nesse bloco aqui ele vai obter o dado da ami com esse data*/
  }
    /*nessa parte aqui estou faazendo um filtro mais detalhado
    onde esse "owners" é qual dono das imagens que eu quero filtrar*/
  owners = ["099720109477"] # ubuntu

}

/*Esse bloco vai um recurso no cloud, vai criar uma maquina virtual*/ /*e depois ele vai redenrizar essa ami a parti da informação obtida do atributo obtido do data*/
resource "aws_instance" "web" {
  /*O ami é a amazon machine image que se trata-se de um modelo que contem
  o sistema operacional, os arquivos de configuração e os programas necessarios para iniciar
  uma maquina virtual*/
  ami = data.aws_ami.ubuntu.id /*vai mostrar so o atributo id obtido no data*/
  /*"ami-0885b1g6bd170450c" image ubuntu especificar*/
  /*cada ami tem sua região especifica*/
  instance_type = "t2.micro"

  tags = {
    name = "hello world"
  }
}

/*Por eu ter criado um novo resource utilizando um provider de regiao diferente
tenho que criar outro data, pois todas essas informaçoes é de outra região*/
data "aws_ami" "ubuntu-west-2" {
  most_recent = true
  provider = aws.west-2

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal/20.04--amf64-server-*"]
  }

  owners = ["099720109477"]
}

/*esse bloco resource foi criado utilizando a logica dos multiplos providers*/
resource "aws_instance" "web-west-2" {

  count = var.servers
/* A utilização do count é a possbilidade de criar mais de um recurso com as mesmas configurações*/

  provider = aws.west-2 /*esse west-2 é o nome do alias que declarei no main*/

  ami = data.aws_ami.ubuntu-west-2.id
  instance_type = "t2.micro"

  tags = {
    name = "hello world"
  }
}

/*o comando terraform console é literalmente um console onde voce pode interragir com o state*/
/*se no bloco resource na parte ami = "ami-0885b1g6bd170450c" e trocar por ami = data.aws_ami.ubuntu
e fazer o terraform console data.aws_ami.ubuntu 
ele vai mostrar todos os atributos dessa imagen
se eu especificar data.aws_ami.ubuntu.id, ele só vai mostar o id*/
