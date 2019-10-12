# frozen_string_literal: true

control 'Exim package' do
  title 'should be installed'

  describe package('exim4-daemon-light') do
    it { should be_installed }
  end
end
