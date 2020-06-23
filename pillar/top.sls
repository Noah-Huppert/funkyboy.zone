base:
  '*':
    # Low level system configuration
    - system-config
    - hostname
    - kernel

    # System daemons
    - syslog
    - ufw
    - crond

    # User setup
    - zsh
    - docker
    - users

    # Tools
    - rm-container-script
    - digitalocean-spaces
    - digitalocean-spaces-secret
    - s3cmd
    - s3fs
    - vsv
    - prometheus-push-cli
    - git-secret
    - gpg
    - redis

    # Services
    - backup
    - email
    - email-secret
    - wireguard
    - wireguard-secret
    - caddy
    - caddy-secret
    - prometheus
    - prometheus-secret
    - alertmanager
    - alertmanager-secret
    - grafana 
    - node-exporter
    - pushgateway
    - scripts-repo
    - znc-secret
    - znc
    - factorio
    - factorio-secret
    - public-www
    - valorant-discord-bot
    - valorant-discord-bot-secret
