# vim: ft=sls
# How to install mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_user:
  user.present:
    - name: mattermost
    - gid_from_name: true
    - home: /var/lib/mattermost
    - empty_password: true
    - shell: /usr/sbin/nologin

mattermost_archive:
  archive.extracted:
    - name: /opt
    - source: https://releases.mattermost.com/{{ mattermost.version }}/mattermost-team-{{ mattermost.version }}-linux-amd64.tar.gz
    - source_hash: sha256={{ mattermost.hash }}
    - archive_format: tar
    - tar_options: ''
    - if_missing: /opt/mattermost

{% if mattermost.mockup %}
mattermost_mockup_pkgs:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - nginx
{% endif %}
