FROM ruby:3.1

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 4000

# CMD ["bundle", "exec", "jekyll", "serve", "--trace", "--host", "0.0.0.0"]

RUN apt-get update 

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Org Unit/CN=localhost"

# Install Nginx
RUN apt-get install -y nginx

# Configure Nginx to use SSL
RUN echo "server { \
    listen 443 ssl; \
    server_name localhost; \
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt; \
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key; \
    root /app/_site; \
    location / { \
        try_files \$uri \$uri/ =404; \
    } \
}" > /etc/nginx/sites-available/default

# Build the Jekyll site
RUN jekyll build

# Expose port 443 for HTTPS
EXPOSE 443

# Start Nginx and keep the container running
CMD ["nginx", "-g", "daemon off;"]