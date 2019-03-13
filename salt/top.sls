base:
  '*':
    # Salt self configuration
    - salt-config
    - salt-dir-perms

    # Low level system configuration
    - system-config
    - hostname
    - sudo-no-password
    - kernel

    # Higher level system configuration
    - motd

    # System daemons
    - syslog
    - sshd-config
    - ufw
    - crond

    # User setup
    # s3cmd and docker before users state so users can be added to groups these 
    # states make
    #
    # Zsh before users so user's default shell can be zsh
    - zsh

    - docker
    - s3cmd

    - users

    # Tools
    - srv-dir-perms
    - rm-container-script
    - xz
    - tree
    - xtools
    - make
    - gcc
    - net-tools
    - nmap
    - s3fs
    - neovim
    - git
    - vsv
    - lnav
    - python
    - go
    - go-dep
    - prometheus-push-cli
    - gpg
    - ensure-access

    # Services
    - backup
    - email
    - wireguard
    - caddy
    - prometheus
    - alertmanager
    - grafana
    - node-exporter
    - pushgateway
    - scripts-repo
    - void-scripts
    - znc
    - factorio
    - funkyboy-website
    - file-modes-website
    - noahhuppert-website
    - workout-website
    - system-guide-website
    - gondola-zone-website
    - public-www
    - linux-install-repo
    - goldblum-zone-website

    # Service logging
    # Placed last so putsvl can modify any services created by any state 
    # before it
    - putsvl
