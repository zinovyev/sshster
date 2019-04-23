RSpec.describe Sshster::Actions::Init do
  let(:config_root_path) { File.expand_path('../../support/tmp', __dir__) }
  let(:config_orig) { config_root_path + '/config.orig' }
  let(:config_path) { config_root_path + '/config' }
  let(:sshster_yml) { config_root_path + '/sshster.yml' }
  let(:projects_dir) { config_root_path + '/sshster' }

  let(:config) do
    {
      'forward_agent' => false,
      'user' => 'deploy',
      'request_tty' => true,
      'screen_session' => 'deploy',
      'ssh_config' => config_root_path,
    }
  end

  let(:action) do
    described_class.new(config)
  end

  after(:each) { FileUtils.rm_rf(config_root_path) }

  describe '#run' do
    context "root directory doesn't exist" do
      before { action.run }

      it 'prepares files and directories structure' do
        expect(Dir).to exist(config_root_path)
        expect(Dir).to exist(projects_dir)
        expect(File).to exist(config_orig)
        expect(File).to exist(sshster_yml)
      end
    end

    context 'configuration file exist' do
      before do
        FileUtils.mkdir_p(config_root_path)
        File.write(config_path, 'foo')
        action.run
      end

      it 'properly backups configuration file' do
        expect(File.read(config_orig)).to eq('foo')
      end
    end
  end
end
