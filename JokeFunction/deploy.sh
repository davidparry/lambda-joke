#!/bin/bash

##./gradlew build
./gradlew clean shadowJar
aws s3 cp build/libs/jokeFunction.jar s3://lambda-functions-devlabs/joke-function/

aws lambda update-function-code \
    --function-name jokeFunction \
    --s3-bucket lambda-functions-devlabs \
    --s3-key joke-function/jokeFunction.jar \
     --publish \
    --no-cli-pager

#S3_VERSION=$(aws s3api head-object \
#    --bucket lambda-functions-devlabs \
#    --key joke-function/jokeFunction.jar \
#    --query 'VersionId' \
#    --output text)

#TIMESTAMP=$(date +%s)
#sam deploy \
#    --template-file template.yaml \
#    --stack-name lambda-devlabs \
#    --capabilities CAPABILITY_IAM \
#    --force-upload \
#    --no-fail-on-empty-changeset \
#    --no-confirm-changeset