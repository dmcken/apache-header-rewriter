FROM httpd:2-bullseye

MAINTAINER SaravAK (aksarav@middlewareinventory.com)

EXPOSE 80

RUN sed -i \
	-e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
	-e 's/^#\(LoadModule .*mod_proxy_http.so\)/\1/' \
	-e 's/^#\(LoadModule .*mod_headers.so\)/\1/' \
	conf/httpd.conf

RUN echo "\n\nInclude conf/local-vhosts.conf\n" >> conf/httpd.conf

COPY local-vhosts.conf /usr/local/apache2/conf/local-vhosts.conf

#CMD  [ "httpd", "-D", "FOREGROUND", "-X", "-e","debug"]
CMD  [ "httpd", "-D", "FOREGROUND" ]
