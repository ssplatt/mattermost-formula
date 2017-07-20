# vim: ft=sls
# How to install mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_archive:
  archive.extracted:
    - name: /opt
    - source: https://releases.mattermost.com/{{ mattermost.version }}/mattermost-team-{{ mattermost.version }}-linux-amd64.tar.gz
    - source_hash: sha256={{ mattermost.hash }}
    - archive_format: tar
    - options: 'zxf'
    - if_missing: /opt/mattermost
