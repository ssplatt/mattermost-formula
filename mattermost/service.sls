# vim: ft=sls
# Manage service for service mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_service:
 service.{{ mattermost.service.state }}:
   - name: {{ mattermost.service.name }}
   - enable: {{ mattermost.service.enable }}
   - watch:
       - file: mattermost_config
       {% if grains.get('oscodename') == 'jessie' -%}
       - file: mattermost_systemd_service_file
       {% else -%}
       - file: mattermost_sysv_service_file
       {%- endif %}

{% if mattermost.mockup %}
mattermost_mockup_db_service:
  service.running:
    - name: mysql
    - enable: true

mattermost_mockup_nginx_service:
  service.running:
    - name: nginx
    - enable: true
    - watch:
      - file: mattermost_mockup_nginx_config
{% endif %}
