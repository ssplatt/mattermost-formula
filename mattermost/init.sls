# vim: ft=sls
# Init mattermost
{%- from "mattermost/map.jinja" import mattermost with context %}
{# Below is an example of having a toggle for the state #}

{% if mattermost.enabled %}
include:
  {% if mattermost.mockup -%}
  - mattermost.mockup
  {%- endif %}
  - mattermost.install
  - mattermost.config
  - mattermost.service
{% else %}
'mattermost-formula disabled':
  test.succeed_without_changes
{% endif %}
