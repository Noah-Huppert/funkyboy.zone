{% set svc_name = "wallet-server" %}
{% set install_dir = "/opt/wallet-service" %}

wallet_service:
  # Git repository
  git_uri: git@github.com:Noah-Huppert/wallet-service.git

  # Directory bot will be installed
  install_dir: {{ install_dir }}

  # Mongo DB script
  mongodb_script: /etc/sv/{{ svc_name }}/mongodb

  # Service
  svc_name: {{ svc_name }}
  svc_run_file: /etc/sv/{{ svc_name }}/run
  svc_log_file: /etc/sv/{{ svc_name }}/log/run
  svc_finish_file: /etc/sv/{{ svc_name }}/finish

  # Configuration file
  secret_config_file: {{ install_dir }}/src/secret.config.js

  # MongoDB container
  mongo:
    container_name: prod-wallet-service-mongo

  # Caddyfile name
  caddyfile: wallet-service

  # Reverse proxy hosts
  api_server:
    hosts: wallet-service.funkyboy.zone
    port: 8000
  
  # Host for Prometheus metrics
  metrics_server:
    host: 127.0.0.1:8001
