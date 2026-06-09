import json
import boto3
import uuid

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("clouddeployx-contacts")

def lambda_handler(event, context):

    print(event)

    if "body" not in event:
        return {
            "statusCode": 400,
            "body": json.dumps({
                "error": "Missing request body"
            })
        }

    body = json.loads(event["body"])

    name = body.get("name")
    email = body.get("email")
    message = body.get("message")

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
        "headers": {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "OPTIONS,POST"
        },
        "body": json.dumps({
            "message": "Contact saved"
        })
    }
