FROM alpine:latest@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# renovate: datasource=repology depName=alpine_edge/nginx versioning=loose
ENV NGINX_VERSION="1.30.4-r1"

# Install NGINX and the fancyindex module together from Alpine's repo
RUN apk add --no-cache \
    nginx=${NGINX_VERSION} \
    nginx-mod-http-fancyindex

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
