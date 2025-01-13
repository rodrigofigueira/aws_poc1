
# POC 1

Integração de Lambda com DynamoDB

![Desenho](img/poc1.png)

# Testando por CLI

aws lambda invoke --function-name integracao_dynamo --payload fileb://event.json output.txt