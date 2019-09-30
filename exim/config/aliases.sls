# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

{%- set aliases         = exim.aliases | default({}) %}
{%- set virtual_aliases = exim.virtual_aliases | default({}) %}

{%- for name, targets in aliases | dictsort %}
exim/alias/{{ name }}:
{%- if not targets %}
  alias.absent:
    - name: {{ name }}
{%- else %}
  alias.present:
    - name: {{ name }}
    - target:
  {%- if targets is list %}
    {%- for target in targets %}
      - {{ target }}
    {%- endfor %}
  {%- else %}
        {{ targets }}
  {%- endif %}
{%- endif %}
{%- endfor %}

{%- if virtual_aliases %}
exim/virtual-aliases/dir:
  file.directory:
    - name: {{ exim.virtual_aliases_dir }}
{%- endif %}

{%- for domain, aliases in virtual_aliases | dictsort %}
exim/virtual-aliases/{{ domain }}:
  file.managed:
    - name: {{ exim.virtual_aliases_dir }}/{{ domain }}
    - source: salt://exim/files/virtual_aliases.jinja
    - template: jinja
    - context:
        aliases: {{ aliases|json }}
        domain: {{ domain }}
{%- endfor %}
