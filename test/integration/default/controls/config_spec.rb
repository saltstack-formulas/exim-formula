control 'Exim configuration' do
  title 'should match desired lines'

  describe file('/etc/exim4/update-exim4.conf.conf') do
    # Default config
    its('content') { should include "dc_eximconfig_configtype='satellite'" }

    # Custom config
    its('content') { should include "dc_hide_mailname='false'" }
  end
end
