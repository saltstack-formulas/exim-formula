# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

{%- set exim_config       = exim.config | default({}) %}
{%- set use_split_config  = exim_config.use_split_config | default('true') %}
{%- set configtype        = exim_config.configtype | default('satellite') %}
{%- set hide_mailname     = exim_config.hide_mailname | default('true') %}
{%- set ue4c_keepcomments = exim_config.ue4c_keepcomments | default('true') %}
{%- set localdelivery     = exim_config.localdelivery | default('mail_spool') %}
{%- set local_interfaces  = exim_config.local_interfaces | default('') %}
{%- set minimaldns        = exim_config.minimaldns | default('false') %}
{%- set other_hostnames   = exim_config.other_hostnames | default('') %}
{%- set readhost          = exim_config.readhost | default('') %}
{%- set relay_domains     = exim_config.relay_domains | default('') %}
{%- set relay_nets        = exim_config.relay_nets | default('') %}
{%- set smarthost         = exim_config.smarthost | default('') %}
{%- set cfilemode         = exim_config.cfilemode | default('644') %}

{{ exim.config_dir }}/{{ exim.config_file }}:
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

{%- if salt['pillar.get']('exim:files') %}
{%- for dir in exim.sub_dirs %}
  {%- for file in salt['pillar.get']('exim:files:' + dir, {}) %}
{{ exim.config_dir }}/conf.d/{{ dir }}/{{ file }}:
  file.managed:
    - contents_pillar: exim:files:{{ dir }}:{{ file }}
  {%- endfor %}
{%- endfor %}
{%- endif %}
