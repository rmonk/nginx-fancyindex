FROM alpine:latest@sha256:fd791d74b68913cbb027c6546007b3f0d3bc45125f797758156952bc2d6daf40

# Install NGINX and the fancyindex module together from Alpine's repo
RUN apk add --no-cache nginx nginx-mod-http-fancyindex

# Automatically load the fancyindex module
#RUN echo "load_module modules/ngx_http_fancyindex_module.so;" > /etc/nginx/modules/ngx_http_fancyindex.conf

# Direct NGINX logs to stdout/stderr so `podman logs` / `docker logs` work properly
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
