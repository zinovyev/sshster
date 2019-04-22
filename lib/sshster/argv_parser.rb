module Sshster
  class ArgvParser
    attr_reader :config, :command, :help

    def initialize(argv)
      @argv = argv
    end

    def parse
      options = parse_argv(@argv)
      @config = options['-c']
      @help = options['-h']
      @command = detect_command(options)
      self
    end

    def valid?
      !@command.nil? && valid_commands.include?(@command)
    end

    private

    def valid_commands
      %i[init compose help]
    end

    def detect_command(options)
      command = options.find { |_k, v| v.nil? }
      command[0].to_sym if command
    end

    def parse_argv(argv)
      Hash[argv.join(' ').scan(/(-?[^=\s]+)(?: ([^-]{1}[\S]+))?/)]
    end
  end
end
