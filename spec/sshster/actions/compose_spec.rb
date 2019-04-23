RSpec.describe Sshster::Actions::Compose do
  let(:config_root_path) { File.expand_path('../../support/tmp', __dir__) }
  let(:config_orig) { config_root_path + '/config.orig' }
  let(:config_path) { config_root_path + '/config' }
  let(:sshster_yml) { config_root_path + '/sshster.yml' }
  let(:projects_dir) { config_root_path + '/sshster' }
  let(:projects1_path) { File.expand_path('../../support/projects.yml', __dir__) }
  let(:projects2_path) { File.expand_path('../../support/projects2.yml', __dir__) }

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

  # after(:each) { FileUtils.rm_rf(config_root_path) }

  describe '#run' do
    context 'configuration file exist' do
      before do
        FileUtils.mkdir_p(projects_dir)
        File.write(config_orig, 'foo')
        File.write(config_path, 'boo')
        FileUtils.cp(projects1_path, projects_dir)
        FileUtils.cp(projects2_path, projects_dir)
        action.run
      end

      it 'compiles ssh configuration file' do
      end
    end
  end
end
