# Installs dcron and sets it up to be the cron daemon.

{% set pkg = 'dcron' %}
{% set svc = 'crond' %}

{{ pkg }}:
  pkg.installed

{{ svc }}-enabled:
  service.enabled:
    - name: {{ svc }}
    - require:
      - pkg: {{ pkg }}

{{ svc }}-running:
  service.running:
    - name: {{ svc }}
    - require:
      - service: {{ svc }}-enabled
