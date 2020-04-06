FROM nginx:alpine

COPY .configs/dev/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
VOLUME ["/var/log/nginx", "/etc/nginx/conf.d"]

CMD ["nginx", "-g", "daemon off;"]