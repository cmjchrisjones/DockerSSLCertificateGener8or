FROM alpine:3.11.3 as certs

RUN apk add openssl

WORKDIR /

COPY ./certs.sh /

CMD ["sh", "/certs.sh"]