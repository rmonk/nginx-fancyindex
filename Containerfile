FROM alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

# renovate: datasource=repology depName=alpine_3_24/nginx versioning=loose
ENV NGINX_VERSION="1.30.4-r1"

# Using =~ allows apk to pull matching patch revisions for both modules
RUN apk add --no-cache \
    nginx=~${NGINX_VERSION} \
    nginx-mod-http-fancyindex

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
