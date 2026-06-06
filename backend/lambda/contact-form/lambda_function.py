import json
import boto3
import uuid

dynamodb = boto3.resource("dynamodb")

table = dynamodb.Table("clouddeployx-contacts")

def lambda_handler(event, context):

    body = json.loads(event["body"])

    name = body["name"]
    email = body["email"]
    message = body["message"]

    table.put_item(
        Item={
            "id": str(uuid.uuid4()),
            "name": name,
            "email": email,
            "message": message
        }
    )

    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Contact saved"
        })
    }
