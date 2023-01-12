FROM httpd:2-bullseye

MAINTAINER dmcken (dmcken at github)

EXPOSE 80

# Enabled the needed modules in the main config file.
RUN sed -i \
	-e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
	-e 's/^#\(LoadModule .*mod_proxy_http.so\)/\1/' \
	-e 's/^#\(LoadModule .*mod_headers.so\)/\1/' \
	conf/httpd.conf

# Import our config file at the end so we can override anything we need to.
RUN echo "\nInclude conf/local-vhosts.conf\n" >> conf/httpd.conf

# Copy our config into the container.
COPY local-vhosts.conf /usr/local/apache2/conf/local-vhosts.conf

# If you need to debug use the first CMD entry.
#CMD  [ "httpd", "-D", "FOREGROUND", "-X", "-e","debug"]
CMD  [ "httpd", "-D", "FOREGROUND" ]
