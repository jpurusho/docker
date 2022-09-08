# Pull nginx base image
FROM nginx:latest

# Expost port 80
EXPOSE 80

# Copy custom configuration file from the current directory
COPY buildweb.conf /etc/nginx/conf.d/buildweb.conf

# Copy static assets into var/www
# COPY ./dist /var/www

# Start up nginx server
# CMD ["nginx"]
