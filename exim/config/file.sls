# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

include:
  - {{ sls_package_install }}

{{ exim.config_dir }}/{{ exim.config_file }}:
  file.managed:
    - contents: |
        dc_eximconfig_configtype='{{ exim.config.configtype }}'
        dc_other_hostnames='{{ exim.config.other_hostnames }}'
        dc_local_interfaces='{{ exim.config.local_interfaces }}'
        dc_relay_domains='{{ exim.config.relay_domains }}'
        dc_relay_nets='{{ exim.config.relay_nets }}'
        dc_use_split_config='{{ exim.config.use_split_config }}'
        dc_hide_mailname='{{ exim.config.hide_mailname }}'
        ue4c_keepcomments='{{ exim.config.ue4c_keepcomments }}'
        dc_localdelivery='{{ exim.config.localdelivery }}'
        dc_minimaldns='{{ exim.config.minimaldns }}'
        dc_readhost='{{ exim.config.readhost }}'
        dc_smarthost='{{ exim.config.smarthost }}'
        CFILEMODE='{{ exim.config.cfilemode }}'
    - require:
      - sls: {{ sls_package_install }}

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
