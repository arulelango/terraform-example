import boto3

client = boto3.client('stepfunctions')

response = client.start_execution(
    stateMachineArn='string',
    name='string',
    input='string',
    traceHeader='string'
)

