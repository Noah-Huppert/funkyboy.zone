# Builds my personal website

{{ pillar.noahhuppert_website.repo }}:
  git.latest:
    - target: {{ pillar.caddy.serve_dir }}/{{ pillar.caddy.static_sites.noahhuppert.clone_dir }}
    - force_clone: True
    - force_fetch: True
    - force_reset: True
    - force_checkout: True

build_noahhuppert_com:
  cmd.run:
    - name: bash -c "npm install && npm run prod"
    - cwd: {{ pillar.caddy.serve_dir }}/{{ pillar.caddy.static_sites.noahhuppert.clone_dir }}/{{ pillar.noahhuppert_website.src_dir }}
    - onchanges:
      - git: {{ pillar.noahhuppert_website.repo }}

{{ pillar.caddy.serve_dir }}/{{ pillar.caddy.static_sites.noahhuppert.clone_dir }}:
  file.directory:
    - user: {{ pillar.caddy.files.user }}
    - group: {{ pillar.caddy.files.group }}
    - mode: {{ pillar.caddy.files.mode }}
    - recurse:
      - user
      - group
      - mode
    - require:
      - cmd: build_noahhuppert_com
