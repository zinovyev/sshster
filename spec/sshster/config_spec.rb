RSpec.describe Sshster::Config do
  let(:config_path) { nil }

  let(:config) { described_class.new(config_path) }

  let(:default_options) do
    {
      'forward_agent' => true,
      'user' => 'deploy',
      'request_tty' => true,
      'screen_session' => 'deploy',
      'ssh_config' => '/home/example/.ssh',
    }
  end

  let(:merged_options) do
    {
      'forward_agent' => false,
      'user' => 'admin',
      'request_tty' => true,
      'screen_session' => 'admin',
      'ssh_config' => '/home/example/.ssh',
    }
  end

  describe '#merge' do
    before { config.merge }
    context 'config exists' do
      let(:config_path) { File.expand_path('../support/sshster.yml', __dir__) }
      it 'merges existing config with the default one' do
        expect(config.options).to eq(merged_options)
      end
    end

    context 'config absent' do
      it 'returns a default config values' do
        expect(config.options).to eq(default_options)
      end
    end
  end

  describe '#default_file_path' do
    it 'detects default configuration file path' do
      expect(config.send(:default_file_path)).to eq('/home/example/.ssh/sshster.yml')
    end
  end

  describe '#default_ssh_config_path' do
    it 'detects default projects path' do
      expect(config.send(:default_ssh_config_path)).to eq('/home/example/.ssh')
    end
  end
end
