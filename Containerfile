FROM alpine:3.24@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

# renovate: datasource=repology depName=alpine_3_24/nginx versioning=loose
ENV NGINX_VERSION="1.30.6-r0"

# Using =~ allows apk to pull matching patch revisions for both modules
RUN apk add --no-cache \
    nginx=~${NGINX_VERSION} \
    nginx-mod-http-fancyindex

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
