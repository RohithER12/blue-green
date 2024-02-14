FROM nginx:latest

# Copy HTML files
COPY green.html /usr/share/nginx/html
COPY blue.html /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d

# Customize Nginx configuration (optional)
# EXPOSE 80 # Not needed as Kubernetes Service exposes it

# Entrypoint command
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
