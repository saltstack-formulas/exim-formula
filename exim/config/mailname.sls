# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

{%- set mailname = exim.mailname | default(salt['grains.get']('fqdn')) %}

include:
  - {{ sls_package_install }}

exim/config/mailname:
  file.managed:
    - name: {{ exim.mailname_file }}
    - contents: {{ mailname }}
    - require:
      - sls: {{ sls_package_install }}
