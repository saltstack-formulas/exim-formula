# -*- coding: utf-8 -*-
# vim: ft=yaml
---
exim:
  config:
    configtype: satellite
    hide_mailname: 'false'
    use_split_config: false
    other_hostnames:
      - foo.bar.baz
      - bar.baz.foo
    local_interfaces: 127.0.0.1
  mailname: foo.bar.baz
  aliases:
    root: root@bar.baz
