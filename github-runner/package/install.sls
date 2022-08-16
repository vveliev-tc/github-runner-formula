# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as github__runner with context %}

github-runner-package-install-pkg-installed:
  pkg.installed:
    - name: {{ github__runner.pkg.name }}
