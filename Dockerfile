FROM golang AS builder
RUN wget https://get.symfony.com/cli/installer -O - | bash

FROM scratch
COPY --from=builder /root/.symfony/bin/symfony /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
CMD ["/symfony", "check:security"]
