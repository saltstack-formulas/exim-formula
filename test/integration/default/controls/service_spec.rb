control 'Exim service' do
  title 'should be running and enabled'

  describe service('exim4') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(25) do
    it { should be_listening }
    its('processes') { should include 'exim4' }
    its('protocols') { should include 'tcp' }
    its('addresses') { should include '0.0.0.0' }
    its('addresses') { should include '::' }
  end
end
