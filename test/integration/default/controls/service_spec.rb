control 'Exim service' do
  title 'should be running and enabled'

  describe service('exim4') do
    it { should be_enabled }
    it { should be_running }
  end

end
