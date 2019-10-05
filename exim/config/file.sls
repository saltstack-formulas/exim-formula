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

{%- if salt['pillar.get']('exim:files') %}
{%- for dir in exim.sub_dirs %}
  {%- for file in salt['pillar.get']('exim:files:' + dir, {}) %}
{{ exim.config_dir }}/conf.d/{{ dir }}/{{ file }}:
  file.managed:
    - contents_pillar: exim:files:{{ dir }}:{{ file }}
    - require:
      - sls: {{ sls_package_install }}
  {%- endfor %}
{%- endfor %}
{%- endif %}
