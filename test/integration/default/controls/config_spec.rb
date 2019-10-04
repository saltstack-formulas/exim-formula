control 'Exim configuration' do
  title 'should match desired lines'

  describe file('/etc/exim4/update-exim4.conf.conf') do
    # Default config
    its('content') { should include "dc_eximconfig_configtype='satellite'" }

    # Custom config
    its('content') { should include "dc_hide_mailname='false'" }
    its('content') { should include "dc_use_split_config='false'" }
  end

  describe file('/etc/mailname') do
    # Custom config
    its('content') { should include 'foo.bar.baz' }
  end

  describe file('/etc/aliases') do
    # Custom config
    its('content') { should include 'root: root@bar.baz' }
  end
end
