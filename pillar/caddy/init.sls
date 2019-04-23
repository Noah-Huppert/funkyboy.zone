# The sites section of the configuration allows virtual hosts which simply 
# server static content to be configured.
#
# The static_sites section holds a series of maps which contain the keys:
#
#   - www_dir (String): Name of directory inside serve_dir which static content 
#                       will be served out of
#   - hosts (String[]): List of hosts which content will be served out of,
#                       should not include a scheme
#   - browse (Boolean): (Optional) If true makes Caddy show file listing page

{% set build_dir = '/opt/caddy' %}

caddy:
  # Build
  build:
    # Directory to build in
    directory: {{ build_dir }}

    # Script to build with
    build_script: {{ build_dir }}/build.sh

    # Script which runs build.sh with correct options
    run_build_script: {{ build_dir }}/run-build.sh

    # Script used to check if Caddy is already built and installed
    check_script: {{ build_dir }}/check-installed.sh

    # Script which runs check-installed.sh with correct options
    run_check_script: {{ build_dir }}/run-check-installed.sh

    # GOPATH to build in
    gopath: {{ build_dir }}/build-gopath

    # Caddy repo to build
    repo: github.com/mholt/caddy/caddy

    # File in repo to add plugin imports to
    plugins_file: caddymain/run.go

    # File to record names of plugins which were installed during last build
    plugins_history_file: {{ build_dir }}/plugins-history

    # List of plugins to import into plugins_file
    plugins:
      # Digital Ocean DNS-01 Let's Encrypt
      - 'github.com/caddyserver/dnsproviders/digitalocean'

      # JWT support
      - 'github.com/BTBurke/caddy-jwt'

      # OAuth & htpasswd resource authentication
      - 'github.com/tarent/loginsrv/caddy'

      # Prometheus metrics exporter
      - 'github.com/miekg/caddy-prometheus'

    # If file is present the check build script will always say caddy is up to
    # date even if it is not. Used to prevent building caddy when the process
    # is broken
    nobuild_file: {{ build_dir }}/nobuild

  # Config
  serve_dir: /srv/caddy
  config_parent_dir: /etc/caddy
  config_dir: /etc/caddy/Caddyfile.d
  config_file: /etc/caddy/Caddyfile
  caddy_path: /var/lib/caddy
  files:
    user: caddy
    group: caddy
    mode: 775

  # Host which metrics for Prometheus will be available on
  metrics_host: 'localhost:9180'

  # Sites
  tls: True
  static_sites:
    # Funky Boy Homepage
    funkyboy:
      www_dir: funkyboy
      hosts:
        {% for subdomain in [ '', '*.' ] %}
        - '{{ subdomain }}funkyboy.zone'
        {% endfor %}

    # Personal website
    noahhuppert:
      www_parent_dir: noahhuppert
      www_dir: noahhuppert/www
      hosts:
        {% for host in [ 'noahh.io', 'noahhuppert.com' ] %}
        {% for subdomain in [ '', '*.' ] %}
        - '{{ subdomain }}{{ host }}'
        {% endfor %}
        {% endfor %}

    # Linux file mode permissions cheat sheet site
    file_modes:
      www_dir: file-modes
      hosts:
        - modes.funkyboy.zone

    # Workout plan site
    workout:
      www_dir: workout
      hosts:
        - swoll.funkyboy.zone

    # Public content
    public_www:
      www_dir: public-www
      browse: True
      hosts:
        - public.funkyboy.zone

    # System guide site
    system_guide:
      www_dir: system-guide
      hosts:
        - guide.funkyboy.zone

    # gondola.zone site
    gondola_zone:
      www_dir: gondola-zone
      hosts:
        - gondola.zone
        - '*.gondola.zone'

    # goldblum.zone site
    goldblum_zone:
      www_dir: goldblum-zone
      hosts:
        - goldblum.zone
        - '*.goldblum.zone'

    # Wireguard public key site
    wireguard_public_key:
      www_dir: wireguard-guide
      hosts:
        - wireguard.funkyboy.zone

    # Wiki site
    wiki:
      www_dir: wiki
      hosts:
        - wiki.funkyboy.zone

    # Game deals website
    game_deals:
      www_dir: game-deals
      hosts:
        - oliversgame.deals
        - '*.oliversgame.deals'
