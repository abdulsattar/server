{ config, pkgs, ...}:
{
  services.nginx = {
    enable = true;
    httpConfig = ''
      ##
      # Basic Settings
      ##

      sendfile on;
      tcp_nopush on;
      tcp_nodelay on;
      keepalive_timeout 65;
      types_hash_max_size 2048;
      # server_tokens off;

      # server_names_hash_bucket_size 64;
      # server_name_in_redirect off;

      #include /etc/nginx/mime.types;
      #default_type application/octet-stream;

      ##
      # Logging Settings
      ##

      access_log /var/log/nginx/access.log;
      error_log /var/log/nginx/error.log;

      ##
      # Gzip Settings
      ##

      gzip on;
      gzip_disable "msie6";

      # gzip_vary on;
      # gzip_proxied any;
      # gzip_comp_level 6;
      # gzip_buffers 16 8k;
      # gzip_http_version 1.1;
      # gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

      ##
      # nginx-naxsi config
      ##
      # Uncomment it if you installed nginx-naxsi
      ##

      #include /etc/nginx/naxsi_core.rules;

      ##
      # nginx-passenger config
      ##
      # Uncomment it if you installed nginx-passenger
      ##

      #passenger_root /usr;
      #passenger_ruby /usr/bin/ruby;

      ##
      # Virtual Host Configs
      ##
      server {
            listen      80;
            server_name bimorphic.com;
            return 301 https://bimorphic.com$request_uri;
      }
      server {
        listen 443 default_server;
        listen [::]:443 default_server ipv6only=on;

        root /var/www/bimorphic.com;
        index index.html index.htm;

        server_name bimorphic.com;

        ssl on;
        ssl_certificate     /etc/ssl/nginx/bimorphic.crt;
        ssl_certificate_key /etc/ssl/nginx/bimorphic.key;

        ssl_session_cache shared:SSL:10m;
        ssl_session_timeout 5m;

        ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384 EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4 EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS";

        ssl_prefer_server_ciphers on;

        location / {
          # First attempt to serve request as file, then
          # as directory, then fall back to displaying a 404.
          try_files $uri $uri/ =404;
          # Uncomment to enable naxsi on this location
          # include /etc/nginx/naxsi.rules
        }
      }
    '';
  };
}
