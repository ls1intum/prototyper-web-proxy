#!/bin/bash

domain="prototyper.example.com" #FIXME
email="info@example.com"        #FIXME
certbot_path="./cerbot"

# Downloading TLS paramters from certbot git-repo"
echo "Downloading TLS paramters"
mkdir -p "$certbot_path/conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$certbot_path/conf/options-ssl-nginx.conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$certbot_path/conf/ssl-dhparams.pem"

# Create dummy ceritificate
echo "Create dummy certificate for $domain"
certs_path="/etc/letsencrypt/live/$domain"
mkdir -p "$certbot_path/conf/live/$domain"
docker-compose run --rm --entrypoint "openssl req -x509 -nodes -newkey rsa:1024 -days 1 -keyout '$certs_path/privkey.pem' -out '$certs_path/fullchain.pem' -subj '/CN=localhost'" certbot

# Start nginx container for the first time
echo "Staring nginx container"
docker-compose up --force-recreate -d nginx

# Delete previously created dummy certificate before requesting proper ones
echo "Delete dummy certificate for $domain"
docker-compose run --rm --entrypoint " rm -Rf /etc/letsencrypt/live/$domain &&  rm -Rf /etc/letsencrypt/archive/$domain && rm -Rf /etc/letsencrypt/renewal/$domain.conf" certbot

# Request Let's Encrypt certificate with certbot
echo "Request  certificate for $domain"
docker-compose run --rm --entrypoint "certbot certonly --webroot -w /var/www/certbot --email $email -d $domain --rsa-key-size 4096 --agree-tos --force-renewal" certbot

# Restart nginx after retrieving new certificates
echo "Restart nginx"
docker-compose exec nginx nginx -s reload
