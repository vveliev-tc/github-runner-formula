# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as github__runner with context %}

include:
  - {{ sls_service_clean }}

github-runner-config-clean-file-absent:
  file.absent:
    - name: {{ github__runner.config }}
    - require:
      - sls: {{ sls_service_clean }}
