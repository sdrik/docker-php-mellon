ARG base=latest
FROM sdrik/php:$base

RUN apt-get update && apt-get install -y \
	libapache2-mod-auth-mellon \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.d/ /etc/entrypoint.d/
COPY apache2/ /etc/apache2/

CMD ["apache2-foreground"]
ONBUILD CMD ["apache2-foreground"]
