import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_host(host):
    assert host.package('metricbeat-elastic').is_installed
    assert host.service('metricbeat-elastic').is_running
    assert host.service('metricbeat-elastic').is_enabled
