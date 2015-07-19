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
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /var/www/bimorphic.com;
        index index.html index.htm;

        server_name test.bimorphic.com;

        location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        try_files $uri =404;
        # Uncomment to enable naxsi on this location
        # include /etc/nginx/naxsi.rules
        }
      }
    '';
  };
}
