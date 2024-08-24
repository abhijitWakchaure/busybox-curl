FROM alpine:latest AS certs
RUN apk update && apk add ca-certificates

# Use BusyBox as the base image
FROM busybox:latest
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY ./bin/* /bin/