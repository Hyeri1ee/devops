FROM alpine:latest

RUN apk add --no-cache bash curl jq

WORKDIR /app

COPY add_contacts.sh .
COPY data.txt .

RUN chmod +x add_contacts.sh

ENTRYPOINT ["./add_contacts.sh"]