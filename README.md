# nephelaiio.heartbeat

[![Build Status](https://travis-ci.org/nephelaiio/ansible-role-heartbeat.svg?branch=master)](https://travis-ci.org/nephelaiio/ansible-role-heartbeat)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nephelaiio.heartbeat-blue.svg)](https://galaxy.ansible.com/nephelaiio/heartbeat/)

An [ansible role](https://galaxy.ansible.com/nephelaiio/heartbeat) to install and configure heartbeat

## Role Variables

Please refer to the [defaults file](/defaults/main.yml) for an up to date list of input parameters.

## Dependencies

* [nephelaiio.elastic_repo](https://galaxy.ansible.com/nephelaiio/elastic_repo/)

Please review the [dependency configuration](/meta/main.yml) for more details

## Example Playbook

```
- hosts: servers
  vars:
    heartbeat_package_state: latest
    heartbeat_conf_manage: yes
    heartbeat_conf:
      heartbeat:
        monitors:
          - type: http
            schedule: '*/1 * * * * * *'
            urls:
              - "https://www.google.com"
              - "https://www.amazon.com"
      output:
        elasticsearch:
          enabled: true
          hosts:
            - http://localhost:9200
      setup:
        dashboards:
          enabled: true
          beat: heartbeat
          always_kibana: true
        template:
          enabled: true
        kibana:
          host: http://localhost:80
  roles:
     - role: nephelaiio.heartbeat
```

## Testing

Please make sure your environment has [docker](https://www.docker.com) installed in order to run role validation tests. Additional python dependencies are listed in the [requirements file](https://github.com/nephelaiio/ansible-role-requirements/blob/master/requirements.txt)

Role is tested against the following distributions (docker images):
  * Ubuntu Bionic
  * Ubuntu Xenial
  * CentOS 7
  * Debian Stretch

You can test the role directly from sources using command ` molecule test `

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
