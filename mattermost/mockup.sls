# vim: ft=sls
{%- from "mattermost/map.jinja" import mattermost with context %}

mattermost_mockup_user:
  user.present:
    - name: mattermost
    - gid_from_name: true
    - home: /var/lib/mattermost
    - empty_password: true
    - shell: /usr/sbin/nologin

mattermost_mockup_pkgs:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - nginx

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
