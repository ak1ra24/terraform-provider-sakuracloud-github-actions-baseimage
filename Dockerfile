FROM hashicorp/terraform:0.12.3

RUN apk --no-cache add jq curl

WORKDIR /
