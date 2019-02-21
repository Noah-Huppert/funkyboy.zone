base:
  '*':
    - salt-config
    - salt-dir-perms
    - system-config
    - srv-dir-perms
    - syslog
    - sshd-config
    - sudo-no-password
    - docker
    - users
    - crond
    - motd
    - xz
    - make
    - gcc
    - backup
    - email
    - neovim
    - zsh
    - git
    - vsv
    - lnav
    - python
    - go
    - prometheus
    - alertmanager
    - node-exporter
    - caddy
    - grafana # Must come after caddy, reverse proxy setup requires caddy
    - scripts-repo
    - void-scripts
    - znc-secret
    - znc
    - funkyboy-website
    - file-modes-website
    - noahhuppert-website
    - workout-website
    - factorio
    - public-www
    - putsvl # Must always be last
