FROM alpine:3.24@sha256:71e9b7bae160ba167fa17414401b94cbcdaf3c32feeab9298bd794a2a0614c35

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
