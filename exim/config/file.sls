# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import map with context %}

{% set use_split_config  = salt['pillar.get']('exim:config:use_split_config', 'true') %}
{% set configtype        = salt['pillar.get']('exim:config:configtype', 'satellite') %}
{% set hide_mailname     = salt['pillar.get']('exim:config:hide_mailname', 'true') %}
{% set ue4c_keepcomments = salt['pillar.get']('exim:config:ue4c_keepcomments', 'true') %}
{% set localdelivery     = salt['pillar.get']('exim:config:localdelivery', 'mail_spool') %}
{% set local_interfaces  = salt['pillar.get']('exim:config:local_interfaces', '') %}
{% set minimaldns        = salt['pillar.get']('exim:config:minimaldns', 'false') %}
{% set other_hostnames   = salt['pillar.get']('exim:config:other_hostnames', '') %}
{% set readhost          = salt['pillar.get']('exim:config:readhost', '') %}
{% set relay_domains     = salt['pillar.get']('exim:config:relay_domains', '') %}
{% set relay_nets        = salt['pillar.get']('exim:config:relay_nets', '') %}
{% set smarthost         = salt['pillar.get']('exim:config:smarthost', '') %}
{% set cfilemode         = salt['pillar.get']('exim:config:cfilemode', '644') %}

{{ map.config_dir }}/{{ map.config_file }}:
  file.managed:
    - contents: |
        dc_eximconfig_configtype='{{ configtype }}'
        dc_other_hostnames='{{ other_hostnames }}'
        dc_local_interfaces='{{ local_interfaces }}'
        dc_relay_domains='{{ relay_domains }}'
        dc_relay_nets='{{ relay_nets }}'
        dc_use_split_config='{{ use_split_config }}'
        dc_hide_mailname='{{ hide_mailname }}'
        ue4c_keepcomments='{{ ue4c_keepcomments }}'
        dc_localdelivery='{{ localdelivery }}'
        dc_minimaldns='{{ minimaldns }}'
        dc_readhost='{{ readhost }}'
        dc_smarthost='{{ smarthost }}'
        CFILEMODE='{{ cfilemode }}'

{% if salt['pillar.get']('exim:files') %}
{% for dir in map.sub_dirs %}
  {% for file in salt['pillar.get']('exim:files:' + dir, {}) %}
{{ map.config_dir }}/conf.d/{{ dir }}/{{ file }}:
  file.managed:
    - contents_pillar: exim:files:{{ dir }}:{{ file }}
  {% endfor %}
{% endfor %}
{% endif %}
