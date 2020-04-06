FROM nginx:alpine

COPY .configs/dev/nginx/nginx.conf /etc/nginx/conf.d/default.conf
VOLUME ["/var/log/nginx", "/etc/nginx/conf.d"]

CMD ["nginx", "-g", "daemon off;"]