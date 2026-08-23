FROM caddy:2.11.4-builder@sha256:4bdeabce8e79d36b23d1cba7d20598cec2c1117ace960d8ca06071f945e8fc9b AS builder

RUN xcaddy build \
    # renovate: datasource=github-releases depName=lucaslorentz/caddy-docker-proxy
    --with github.com/lucaslorentz/caddy-docker-proxy@v2.13.1 \
    # renovate: datasource=git-refs depName=https://github.com/mholt/caddy-dynamicdns.git
    --with github.com/mholt/caddy-dynamicdns@67d107a42c0279f6e6d58a6afe646745c8b44f78 \
    # renovate: datasource=github-tags depName=caddy-dns/rfc2136
    --with github.com/caddy-dns/rfc2136@v1.0.0

FROM caddy:2.11.4-alpine@sha256:5f5c8640aae01df9654968d946d8f1a56c497f1dd5c5cda4cf95ab7c14d58648

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add -U --no-cache ca-certificates curl

CMD ["caddy", "docker-proxy"]
