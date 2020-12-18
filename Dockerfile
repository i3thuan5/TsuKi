FROM jwilder/nginx-proxy

RUN echo "proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=voice_cache:20m max_size=10g inactive=30d;" > /etc/nginx/conf.d/cache.conf
RUN echo "# client_max_body_size 100m;" > /etc/nginx/vhost.d/default
RUN echo " \
      expires 30d; \
      proxy_cache voice_cache; \
      proxy_buffering on; \
      proxy_buffer_size 6144; \
      proxy_cache_valid 200 206 10d; \
      add_header X-Cache-Status $upstream_cache_status; \
\
      slice              1m; \
      proxy_cache_key    $host$uri$is_args$args$slice_range; \
      proxy_set_header   Range $slice_range; \
      proxy_http_version 1.1; \
    " > /etc/nginx/vhost.d/xn--lhrz38b.xn--v0qr21b.xn--kpry57d

