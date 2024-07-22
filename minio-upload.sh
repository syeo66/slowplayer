#!/bin/bash

# usage: ./minio-upload.sh my-bucket my-file.zip

. s3-access

bucket=$1
file=$2

host=$S3_HOST
s3_key=$S3_KEY
s3_secret=$S3_SECRET

resource="/${bucket}/${file}"
content_type="image/jpeg"
date=`date -R`
_signature="PUT\n\n${content_type}\n${date}\n${resource}"
signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

curl -v -X PUT -T "${file}" \
          -H "Host: $host" \
          -H "Date: ${date}" \
          -H "Content-Type: ${content_type}" \
          -H "Authorization: AWS ${s3_key}:${signature}" \
          https://$host${resource}
