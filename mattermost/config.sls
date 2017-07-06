# vim: ft=sls
# How to configure mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_dir:
  file.directory:
    - name: /opt/mattermost
    - user: mattermost
    - group: mattermost
    - mode: 0755
    - recurse:
      - user
      - group

mattermost_data_dir:
  file.directory:
    - name: {{ mattermost.data_dir }}
    - user: mattermost
    - group: mattermost
    - mode: 0755

mattermost_config:
  file.managed:
    - name: /opt/mattermost/config/config.json
    - source: salt://mattermost/files/config.json.j2
    - template: jinja
    - user: mattermost
    - group: mattermost
    - mode: 0644
    
{% if grains.get('oscodename') == 'jessie' %}
mattermost_systemd_service_file:
  file.managed:
    - name: /usr/lib/systemd/system/mattermost.service
    - source: salt://mattermost/files/systemd_mattermost.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - makedirs: true
{% else %}
mattermost_sysv_service_file:
  file.managed:
    - name: /etc/init.d/mattermost
    - source: salt://mattermost/files/initd_mattermost.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0755
{% endif %}

{% if mattermost.mockup %}
mattermost_mockup_database_user:
  mysql_user.present:
    - name: {{ mattermost.db.user }}
    - password: {{ mattermost.db.password }}

mattermost_mockup_database_db:
  mysql_database.present:
    - name: {{ mattermost.db.database }}

mattermost_mockup_database_query:
  mysql_grants.present:
    - grant: all privileges
    - database: {{ mattermost.db.database }}.*
    - user: {{ mattermost.db.user }}

mattermost_mockup_nginx_config:
  file.managed:
    - name: /etc/nginx/sites-enabled/mattermost
    - source: salt://mattermost/files/mockup_nginx_conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
{% endif %}