FROM caddy:2.10.2-builder@sha256:a642fca0473850425b8b62c9ab33fe14306ec80eb27a007f5f893e7357569451 AS builder

RUN xcaddy build \
    # renovate: datasource=github-releases depName=lucaslorentz/caddy-docker-proxy
    --with github.com/lucaslorentz/caddy-docker-proxy@v2.10.0 \
    # renovate: datasource=git-refs depName=https://github.com/mholt/caddy-dynamicdns.git
    --with github.com/mholt/caddy-dynamicdns@1af4f88765982db86ce091eeb075cfb2d9348dc8 \
    # renovate: datasource=github-tags depName=caddy-dns/rfc2136
    --with github.com/caddy-dns/rfc2136@v1.0.0

FROM caddy:2.10.2-alpine@sha256:f2b257f20955d6be2229bed86bad24193eeb8c4dc962a4031a6eb42344ffa457

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add -U --no-cache ca-certificates curl

CMD ["caddy", "docker-proxy"]
