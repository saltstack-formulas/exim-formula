# frozen_string_literal: true

control 'Exim configuration' do
  title 'should match desired lines'

  describe file('/etc/exim4/update-exim4.conf.conf') do
    # Default config
    its('content') { should include "dc_eximconfig_configtype='satellite'" }

    # Custom config
    its('content') { should include "dc_other_hostnames='foo.bar.baz ; bar.baz.foo'" }
    its('content') { should include "dc_local_interfaces='127.0.0.1'" }
    its('content') { should include "dc_hide_mailname='false'" }
    its('content') { should include "dc_use_split_config='false'" }
  end

  describe file('/etc/mailname') do
    # Custom config
    its('content') { should include 'foo.bar.baz' }
  end

  describe file('/etc/exim4/passwd.client') do
    # Custom config
    its('content') { should include '*:mymail@example.com:abdc1243' }
  end

  describe file('/etc/aliases') do
    # Custom config
    its('content') { should include 'root: root@bar.baz' }
  end
end
