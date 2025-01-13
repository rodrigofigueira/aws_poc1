
# POC 1

Integração de Lambda com DynamoDB

![Desenho](img/poc1.png)

# Provisionando a infra
- terraform init
- terraform plan -out="tfplan.out" ( ou apenas terraform plan )
- terraform apply "tfplan.out" ( ou apenas terraform apply )

# Recursos provisionados

![DynamoDB](img/dynamoDB.png)
![Lambda](img/role.png)
![Lambda](img/lambda1.png)
![Role da Lambda](img/lambda_role_anexada.png)

# Testando por CLI

aws lambda invoke --function-name integracao_dynamo --payload fileb://event.json output.txt

# Registro incluído

![DynamoDB com Registro](img/lambda_role_anexada.png)
