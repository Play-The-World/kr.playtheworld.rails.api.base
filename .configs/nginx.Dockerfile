FROM nginx:alpine
# COPY public /usr/share/nginx/html
COPY nginx/*.conf /etc/nginx/conf.d/
VOLUME ["/var/log/nginx"]