FROM httpd:latest  

# Copy index.html to the document root
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80
EXPOSE 80
