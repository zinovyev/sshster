require 'pry'
require 'pry-coolline'
require 'pathname'
require 'fileutils'

module Sshster
  module Actions
    class Base
      attr_accessor :config

      def initialize(config)
        @config = config
      end

      def run; end

      private

      def config_path
        @config_path ||= root_path.join('config')
      end

      def origin_config_path
        @origin_config_path ||= root_path.join('config.orig')
      end

      def projects_path
        @projects_path ||= root_path.join('sshster')
      end

      def sshster_config_path
        @sshster_config_path ||= root_path.join('sshster.yml')
      end

      def root_path
        @root_path ||= Pathname.new(config['ssh_config'])
      end
    end
  end
end
