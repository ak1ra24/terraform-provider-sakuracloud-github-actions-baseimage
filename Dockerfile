FROM hashicorp/terraform:0.12.3

RUN apk --no-cache add jq curl

ENV TF_SACLOUD_PROVIDER_VERSION="2.2.0"
ENV OS_TYPE=linux
ENV PLUGINS_DIR="~/.terraform.d/plugins/${OS_TYPE}_amd64"
ENV PROVIDER_ZIP="https://github.com/sacloud/terraform-provider-sakuracloud/releases/download/v${TF_SACLOUD_PROVIDER_VERSION}/terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_${OS_TYPE}-amd64.zip"


WORKDIR /

RUN wget ${PROVIDER_ZIP}; \
    unzip terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_${OS_TYPE}-amd64.zip; \
    rm terraform-provider-sakuracloud_${TF_SACLOUD_PROVIDER_VERSION}_${OS_TYPE}-amd64.zip; \
    mv terraform-provider-sakuracloud* terraform-provider-sakuracloud

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
