# This is the main state file for configuring exim,

{% from "exim/map.jinja" import map with context %}

exim_install_packages:
  pkg.installed:
    - pkgs:
      {% for pkg in map.pkgs %}
      - {{ pkg }}
      {% endfor %}  

{% set use_split_config = salt['pillar.get']('exim:config:use_split_config', 'true') %} 
{% set configtype = salt['pillar.get']('exim:config:configtype', 'satellite') %} 
{% set hide_mailname = salt['pillar.get']('exim:config:hide_mailname', 'true') %} 
{% set ue4c_keepcomments = salt['pillar.get']('exim:config:ue4c_keepcomments', 'true') %} 
{% set localdelivery = salt['pillar.get']('exim:config:localdelivery', 'mail_spool') %} 
{% set local_interfaces = salt['pillar.get']('exim:config:local_interfaces', '') %} 
{% set minimaldns = salt['pillar.get']('exim:config:minimaldns', 'false') %} 
{% set other_hostnames = salt['pillar.get']('exim:config:other_hostnames', '') %} 
{% set readhost = salt['pillar.get']('exim:config:readhost', '') %} 
{% set relay_domains = salt['pillar.get']('exim:config:relay_domains', '') %} 
{% set relay_nets = salt['pillar.get']('exim:config:relay_nets', '') %} 
{% set smarthost = salt['pillar.get']('exim:config:smarthost', '') %} 

{{ map.config_dir }}/{{ map.config_file }}:
  file.managed:
    - contents: |
        dc_use_split_config='{{ use_split_config }}'
        dc_eximconfig_configtype='{{ configtype }}'
        dc_hide_mailname='{{ hide_mailname }}'
        ue4c_keepcomments='{{ ue4c_keepcomments }}'
        dc_localdelivery='{{ localdelivery }}'
        dc_local_interfaces='{{ local_interfaces }}'
        dc_minimaldns='{{ minimaldns }}'
        dc_other_hostnames='{{ other_hostnames }}'
        dc_readhost='{{ readhost }}'
        dc_relay_domains='{{ relay_domains }}'
        dc_relay_nets='{{ relay_nets }}'
        dc_smarthost='{{ smarthost }}'
    - watch_in:
      - service: {{ map.service }}

{% for dir in map.sub_dirs %}
  {% for file in salt['pillar.get']('exim:files:' + dir, {}) %}
{{ map.config_dir }}/conf.d/{{ dir }}/{{ file }}:
  file.managed:
    - source: salt://exim/{{ file }}
    - watch_in:
      - service: {{ map.service }}
  {% endfor %}
{% endfor %}

exim_service:
  service.running:
    - name: {{ map.service }}
