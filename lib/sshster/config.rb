module Sshster
  class Config
    attr_accessor :options, :config_path

    def initialize(config_path = nil)
      @config_path = config_path || default_file_path
      @options = default_options
    end

    def merge
      merge_config(config_path)
    end

    private

    def parse_config(config_path)
      YAML.safe_load(File.read(config_path))
    end

    def merge_config(config_path)
      return @options unless File.exist?(config_path)

      @options.merge!(parse_config(config_path))
    end

    def default_options
      {
        'forward_agent' => true,
        'user' => 'deploy',
        'request_tty' => true,
        'screen_session' => 'deploy',
        'ssh_config' => default_ssh_config_path,
      }
    end

    def default_file_path
      ENV['HOME'] + '/.ssh/sshster.yml'
    end

    def default_ssh_config_path
      ENV['HOME'] + '/.ssh'
    end
  end
end
