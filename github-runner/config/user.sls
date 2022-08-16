# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as github_runner with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

github-runner-config-user-group:
    group.present:
        - name: {{ github_runner.usergroup }}

github-runner-config-user-present:
    user.present:
        - name: {{ github_runner.username }}
        - groups:
            - {{ github_runner.usergroup }}
            - docker
        - createhome: true
        # - home: /home/{{ github_runner.username }}
        - require: 
            - ggithub-runner-config-user-group
   