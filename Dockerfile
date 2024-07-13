FROM golang:latest AS builder
WORKDIR /root
COPY . .
RUN go build -o x-ui main.go

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates systemd && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root
COPY --from=builder /root/x-ui /root/x-ui
COPY bin/. /root/bin/.
RUN find /root/bin -type f -exec chmod +x {} \;

VOLUME [ "/etc/x-ui" ]

CMD ["./x-ui"]
