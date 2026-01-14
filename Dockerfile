FROM caddy:2.10.2-builder@sha256:efb93f7af011ef86c2eea10700a1a6fa8d1d99228f2dd94f7c2a12192e44d3c9 AS builder

RUN xcaddy build \
    # renovate: datasource=github-releases depName=lucaslorentz/caddy-docker-proxy
    --with github.com/lucaslorentz/caddy-docker-proxy@v2.10.0 \
    # renovate: datasource=git-refs depName=https://github.com/mholt/caddy-dynamicdns.git
    --with github.com/mholt/caddy-dynamicdns@1af4f88765982db86ce091eeb075cfb2d9348dc8 \
    # renovate: datasource=github-tags depName=caddy-dns/rfc2136
    --with github.com/caddy-dns/rfc2136@v1.0.0

FROM caddy:2.10.2-alpine@sha256:953131cfea8e12bfe1c631a36308e9660e4389f0c3dfb3be957044d3ac92d446

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add -U --no-cache ca-certificates curl

CMD ["caddy", "docker-proxy"]
