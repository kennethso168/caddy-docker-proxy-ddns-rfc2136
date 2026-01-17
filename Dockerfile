FROM caddy:2.10.2-builder@sha256:b6424b4a90e25fde5cb9fd8e1da716159a313869ac3ba1c34b11c50781acab81 AS builder

RUN xcaddy build \
    # renovate: datasource=github-releases depName=lucaslorentz/caddy-docker-proxy
    --with github.com/lucaslorentz/caddy-docker-proxy@v2.10.0 \
    # renovate: datasource=git-refs depName=https://github.com/mholt/caddy-dynamicdns.git
    --with github.com/mholt/caddy-dynamicdns@1af4f88765982db86ce091eeb075cfb2d9348dc8 \
    # renovate: datasource=github-tags depName=caddy-dns/rfc2136
    --with github.com/caddy-dns/rfc2136@v1.0.0

FROM caddy:2.10.2-alpine@sha256:11aadc735925d782bdc5d83344408a9d630ba00cf45e68108e671011bc7386bc

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add -U --no-cache ca-certificates curl

CMD ["caddy", "docker-proxy"]
