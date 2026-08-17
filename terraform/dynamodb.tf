resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
    name = "terraform-state-lock-dynamo"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20

    attribute {
      name = "LockID"
      type = "s"
    }

    tags ={
        name = "DynamoBD terraform state lock table"
    }
}

/*O State Locking (bloqueio de estado) no Terraform é um mecanismo de segurança que impede que 
múltiplas operações modifiquem o arquivo de estado (terraform.tfstate) ao mesmo tempo.

Sempre que você executa um comando que pode alterar a infraestrutura (como terraform apply, terraform plan ou terraform destroy),
o Terraform tenta "trancar" (lock) o arquivo de estado. Se o arquivo já estiver trancado por outro processo,
o Terraform aborta a operação*/