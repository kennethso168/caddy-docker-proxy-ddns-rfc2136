# Caddy Docker Proxy with Dynamic DNS and RFC 2136 modules

[Caddy](https://github.com/caddyserver/caddy) takes a [modular approach](https://caddyserver.com/docs/extending-caddy) to building Docker images, allowing users to include only the [modules](https://caddyserver.com/docs/modules/) they need. There is [serfriz/caddy-custom-builds](https://github.com/serfriz/caddy-custom-builds) that automatically build docker images with certain combinations of modules. However, there is so much possible combinations of modules that building every of them is almost impossible.

Therefore, I have built this repo to automatically build my own image of caddy for my own use with the following modules:

- [lucaslorentz/caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy)
- [mholt/caddy-dynamicdns](https://github.com/mholt/caddy-dynamicdns)
- [caddy-dns/rfc2136](https://github.com/caddy-dns/rfc2136)

In addition, `ca-certificates` and `curl` are installed to the image just like [Caddy Docker Proxy's alpine image](https://github.com/lucaslorentz/caddy-docker-proxy/blob/master/Dockerfile-alpine). This allows accessing the caddy api endpoint for e.g. debugging and graceful reload (See example usecase below)

The versions of caddy and the above modules are tracked by [Renovate](https://www.mend.io/renovate/). With any new versions Renovate automatically updates the relevant version in the Dockerfile and bumps this repo's version at `version.txt`. This triggers GitHub Actions workflow to automatically build the docker image, push it to GitHub Container Registry (GHCR), and create a new release with changelog. Everything is done automatically.

This also serves as an example of how to automatically build a custom caddy image with continuous integration and continuous delivery (CI/CD). It is actually quite easy! Some hints are shared below for making your own custom caddy image.

## Using this image

```
docker pull docker pull ghcr.io/kennethso168/caddy-docker-proxy-ddns-rfc2136
```

I recommend using a specific tag (e.g. `ghcr.io/kennethso168/caddy-docker-proxy-ddns-rfc2136:1.0.0`) instead of the `latest` tag. I put my docker compose stacks in a GitHub repo and track image updates using renovate.

## Versioning

Caddy, caddy-docker-proxy and caddy's rfc2136 all have `semver` like versions (i.e. in the format of `<major>.<minor>.<patch>`). This repo uses `semver` versioning too. Renovate will bump the major, minor or patch part of the version number according to the corresponding part of the new version of the updated component.

For the Dynamic DNS module, unfortunately no releases/tags with version number are provided. Therefore the commit SHA digest is used to pin the version of the module. Renovate still tracks this. All updates of this module will trigger a bump of the minor part of the version number.

From time to time, I may make changes to the repo and bump the version number manually. The part of the version number that get bumped is decided with my discretion. Usually, simple rebuilds have the `patch` part of the version number bumped.

## Testing and release

The repo is configured to auto accept all updates to caddy and its modules unless it is a major version update in the `semver` version number. No testing is done before release of images. Use the images at your own risk.

I personally use this for my homelab, so I may test the released images from time to time manually and indicate as such in the release notes. Similarly, I will add a note or unpublish the release if I find that the image breaks.

Automatic testing may be added in the future.

## Use case

TODO

## Build your own customized caddy image

TODO

## License

GPLv3
