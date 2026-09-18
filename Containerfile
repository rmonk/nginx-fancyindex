FROM alpine:3.24@sha256:5b02b42e375f7426f8d65c3af331ca05d9878f9989230354504e0b9dfd431f60

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
