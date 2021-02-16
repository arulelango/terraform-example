import csv
import urllib.parse
import boto3


print('Loading function')

s3 = boto3.client('s3')

def lambda_handler(event, context):
    #1 - Get the bucket name
    bucket = event['Records'][0]['s3']['bucket']['name']

    #2 - Get the file/key name
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    print("FileName :"+key)
    
    try:
        #3 - Fetch the file from S3
        response = s3.get_object(Bucket=bucket, Key=key)

        # read the contents of the file and split it into a list of lines
        text = response["Body"].read().split()

        for line in csv.DictReader(text):
            print(line)

        return 'Success!'

    except Exception as e:
        print(e)
        raise e


