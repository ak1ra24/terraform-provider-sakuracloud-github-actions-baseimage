FROM hashicorp/terraform:0.12.20

RUN apk --no-cache add jq curl

WORKDIR /
