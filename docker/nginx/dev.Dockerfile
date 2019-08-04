FROM nginx:1.15

RUN apt-get update \
	&& apt-get install -y openssl
RUN mkdir -p /var/www/app

RUN openssl genrsa 2048 > server.key \
	&& openssl req -new -key server.key -subj "/C=JP/ST=Tokyo/L=Chuo-ku/O=RMP Inc./OU=web/CN=localhost" > server.csr \
	&& openssl x509 -in server.csr -days 3650 -req -signkey server.key > server.crt \
	&& cp server.crt /etc/nginx/server.crt \
	&& cp server.key /etc/nginx/server.key \
	&& chmod 755 -R /var/www/app

USER ${www_user}
