FROM alpine:3.23@sha256:fd791d74b68913cbb027c6546007b3f0d3bc45125f797758156952bc2d6daf40

# renovate: datasource=repology depName=alpine_3_23/nginx versioning=loose
ENV NGINX_VERSION="1.30"

# Using =~ allows apk to pull matching patch revisions for both modules
RUN apk add --no-cache \
    nginx=~${NGINX_VERSION} \
    nginx-mod-http-fancyindex

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
