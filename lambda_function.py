import json
import boto3
from datetime import datetime

dynamodb = boto3.resource('dynamodb')

DYNAMODB_TABLE = "integracao_lambda"

def lambda_handler(event, context):
    try:
        # Parse o payload
        body = json.loads(event['body'])

        # Validação simples
        if not body.get("eventId") or not body.get("eventType"):
            return {
                "statusCode": 400,
                "body": json.dumps({"message": "Invalid payload"})
            }

        # Gravar no DynamoDB
        table = dynamodb.Table(DYNAMODB_TABLE)
        table.put_item(Item={
            "Id": body["eventId"],
            "eventType": body["eventType"],
            "timestamp": datetime.utcnow().isoformat(),
            "details": body.get("details", "")
        })

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Event processed successfully"})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"message": "Error processing event", "error": str(e)})
        }
