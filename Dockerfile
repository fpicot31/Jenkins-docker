FROM nginx:1.21.6-alpine

RUN sed -i 's/nginx/Troisiemee test de modification/g' /usr/share/nginx/html/index.html
EXPOSE 80
