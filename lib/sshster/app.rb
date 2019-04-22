require File.expand_path('actions/base', __dir__)
require File.expand_path('actions/init', __dir__)
require File.expand_path('actions/compose', __dir__)
require File.expand_path('actions/help', __dir__)

module Sshster
  class App
    attr_accessor :options

    def initialize(options)
      @options = options
    end

    def run
      case command
      when :init then action_init
      when :compose then action_compose
      when :help then action_help
      else action_help
      end
    end

    def action_init
      Actions::Init.new(config).run
    end

    def action_compose
      action_init
      Actions::Compose.new(config).run
    end

    def action_help
      Actions::Help.new.run
    end

    private

    def config
      @config ||= Config.new(options.config).merge
    end

    def command
      @command ||= @options.command
    end
  end
end
