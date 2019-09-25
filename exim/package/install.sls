# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import exim with context %}

exim/package/install:
  pkg.installed:
    - pkgs: {{ exim.pkgs | json }}
