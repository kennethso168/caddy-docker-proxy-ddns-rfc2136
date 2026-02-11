FROM caddy:2.10.2-builder@sha256:7b2ecf805d4ff19b5c937c13434f7d0916cb550575b092cb95b038be838b4f2e AS builder

RUN xcaddy build \
    # renovate: datasource=github-releases depName=lucaslorentz/caddy-docker-proxy
    --with github.com/lucaslorentz/caddy-docker-proxy@v2.10.0 \
    # renovate: datasource=git-refs depName=https://github.com/mholt/caddy-dynamicdns.git
    --with github.com/mholt/caddy-dynamicdns@1af4f88765982db86ce091eeb075cfb2d9348dc8 \
    # renovate: datasource=github-tags depName=caddy-dns/rfc2136
    --with github.com/caddy-dns/rfc2136@v1.0.0

FROM caddy:2.10.2-alpine@sha256:4c6e91c6ed0e2fa03efd5b44747b625fec79bc9cd06ac5235a779726618e530d

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN apk add -U --no-cache ca-certificates curl

CMD ["caddy", "docker-proxy"]
