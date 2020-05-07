# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

exim/config/install:
  file.managed:
    - name: {{ exim.config_dir }}/{{ exim.config_file }}
    - source: {{ files_switch(['update-exim4.conf.conf'],
                              lookup='exim/config/install'
                 )
              }}
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        exim: {{ exim.config | json }}
    - watch_in:
      - service: exim/service/running

{%- if salt['pillar.get']('exim:files') %}
{%- for dir in exim.sub_dirs %}
  {%- for file in salt['pillar.get']('exim:files:' + dir, {}) %}
  {% set config_subdir_path = '/conf.d/' ~ dir ~ '/' if dir != 'base' else '/' %}
{{ exim.config_dir }}{{ config_subdir_path }}/{{ file }}:
  file.managed:
    - contents_pillar: exim:files:{{ dir }}:{{ file }}
    - require:
      - sls: {{ sls_package_install }}
    - watch_in:
      - service: exim/service/running
  {%- endfor %}
{%- endfor %}
{%- endif %}
