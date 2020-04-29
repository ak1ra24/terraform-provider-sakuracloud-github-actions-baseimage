#!/bin/sh
set -e
cd "${TF_ACTION_WORKING_DIR:-.}"

if [ -z "$TF_SACLOUD_PROVIDER_VERSION" ]; then
	TF_SACLOUD_PROVIDER_VERSION=$(curl -s https://api.github.com/repos/sacloud/terraform-provider-sakuracloud/releases | jq -r '.[0] | .tag_name' | sed -e 's/[^0-9\.]//g')
fi

wget https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v${TF_SACLOUD_PROVIDER_VERSION}/terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_linux-amd64.zip
unzip terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_linux-amd64.zip
rm terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_linux-amd64.zip
mv terraform-provider-sakuracloud* terraform-provider-sakuracloud

if [[ ! -z "$TF_ACTION_TFE_TOKEN" ]]; then
  cat > ~/.terraformrc << EOF
credentials "${TF_ACTION_TFE_HOSTNAME:-app.terraform.io}" {
  token = "$TF_ACTION_TFE_TOKEN"
}
EOF
fi

exit 0
