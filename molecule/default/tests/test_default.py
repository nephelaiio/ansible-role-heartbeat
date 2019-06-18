import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_host(host):
    assert host.package('metricbeat').is_installed
    assert host.service('metricbeat').is_running
    assert host.service('metricbeat').is_enabled
