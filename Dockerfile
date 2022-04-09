FROM golang:1.18-alpine AS builder
RUN wget -O checker https://github.com/fabpot/local-php-security-checker/releases/download/v2.0.3/local-php-security-checker_2.0.3_linux_amd64
RUN chmod 755 checker

FROM scratch
COPY --from=builder /go/checker /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
CMD ["/checker"]
