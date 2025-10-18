# nephelaiio.heartbeat

[![Build Status](https://github.com/nephelaiio/ansible-role-heartbeat/actions/workflows/molecule.yml/badge.svg)](https://github.com/nephelaiio/ansible-role-heartbeat/actions/workflows/molecule.yml)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nephelaiio.heartbeat.vim-blue.svg)](https://galaxy.ansible.com/nephelaiio/heartbeat/)

An [ansible role](https://galaxy.ansible.com/nephelaiio/heartbeat) to install and configure heartbeat

## Role Variables

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Example Playbook

```
- hosts: servers
  vars:
    heartbeat_conf_monitors:
      - type: http
        schedule: '*/1 * * * * * *'
        urls:
          - "https://www.google.com"
          - "https://www.amazon.com"
    heartbeat_conf_output:
      elasticsearch:
        enabled: true
         hosts:
          - http://localhost:9200
  roles:
     - role: nephelaiio.heartbeat
```

## Testing

Please make sure your environment has [devbox](https://www.jetify.com/devbox) [docker](https://www.docker.com) installed in order to run validation tests.

Role is tested against the following distributions (docker images):

- Ubuntu Noble
- Ubuntu Focal
- Ubuntu Bionic
- Rocky Linux 9
- Debian Bullseye

You can test the role directly from sources using commands `devbox install ; devbox run molecule test`

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
