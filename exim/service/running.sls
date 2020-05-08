# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

include:
  - {{ sls_config_file }}

exim/service/running:
  service.running:
    - name: {{ exim.service }}
    - enable: true
    - reload: true
    - watch:
      - sls: {{ sls_config_file }}
