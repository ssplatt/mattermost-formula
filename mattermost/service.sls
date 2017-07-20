# vim: ft=sls
# Manage service for service mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_service:
 service.{{ mattermost.service.state }}:
   - name: {{ mattermost.service.name }}
   - enable: {{ mattermost.service.enable }}
   - watch:
       - file: mattermost_config
