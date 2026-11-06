# Multi-stage: official xray image has no shell, so copy the binary into Alpine
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:3.20
RUN apk add --no-cache ca-certificates tzdata
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY --from=xray /usr/local/share/xray/geoip.dat /usr/local/share/xray/geoip.dat
COPY --from=xray /usr/local/share/xray/geosite.dat /usr/local/share/xray/geosite.dat
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /usr/local/bin/xray
ENTRYPOINT ["/entrypoint.sh"]
