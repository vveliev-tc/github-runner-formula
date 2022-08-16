# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as github_runner with context %}
{%- set packeg_name += github_runner.pkg.name %}
{%- set packeg_name += "-" + github_runner.pkg.os_tag  %}
{%- set packeg_name += "-" + github_runner.arch %}
{%- set packeg_name += "-" + github_runner.pkg.version %}
{%- set packeg_name += "." github_runner.pkg.archive %}
{%- set github_package_url = github_runner.pkg.base_url + "/v" + github_runner.pkg.version + "/" + packeg_name %}

github-runner-package-install-pkg-installed:
  pkg.installed:
    - name: {{ github_runner.pkg.name }}

github-runner-package-install-file-manage:
    file.managed:
        - name: /opt/github-runner/{{ packeg_name }}
        - source: {{ github_package_url }}
        - source_hash: {{ github_runner.pkg.checksums }}
        - require:
            - githubrunner_user