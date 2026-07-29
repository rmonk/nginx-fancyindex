FROM alpine:latest@sha256:fd791d74b68913cbb027c6546007b3f0d3bc45125f797758156952bc2d6daf40

# renovate: datasource=repology depName=alpine_edge/nginx versioning=loose
ENV NGINX_VERSION="1.30.4-r2"

# Install NGINX and the fancyindex module together from Alpine's repo
RUN apk add --no-cache \
    nginx=${NGINX_VERSION} \
    nginx-mod-http-fancyindex

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
