#!/bin/sh -l

export PATH=/usr/local/bin:$PATH

# Verify that wget/tar exist on the system
apt-get update -y && apt-get install -y curl wget tar git apt-transport-https ca-certificates gnupg jq

# Download Helm and extract it to /usr/local/bin
wget https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz
tar -zxvf helm-v3.7.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm

# Add Google SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt-get update -y && apt-get install -y google-cloud-sdk

# Login to Google SDK
echo "$3" | base64 -d >> "$(pwd)/credentials.json"
gcloud auth activate-service-account --key-file="$(pwd)/credentials.json" --project="$4"

# Package Chart
if [ -d "chart-out" ]; then
  /usr/local/bin/helm package "$1" --destination "chart-out"
else
  mkdir "chart-out"
  /usr/local/bin/helm package "$1" --destination "chart-out"
fi

# Push to GCR
gsutil cp "chart-out/*" "$2"

# Reindex and Push Index
if [ -d "bucket-contents" ]; then
  gsutil cp -r "$2" "bucket-contents/"
else
  mkdir "bucket-contents"
  gsutil cp -r "$2" "bucket-contents/"
fi
/usr/local/bin/helm repo index "bucket-contents"
gsutil cp "bucket-contents/index.yaml" "$2"

# Push
#output=$(/usr/local/bin/helm push-artifactory "$1" artifactory --skip-reindex 2>&1)

# Set Output
#echo "::set-output name=output::$output"
