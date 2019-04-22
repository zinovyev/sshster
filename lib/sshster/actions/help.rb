# rubocop:disable all 
module Sshster
  module Actions
    class Help
      def run
        puts <<~HELP
          sshster [-h] [-c] <command>

          Commands:

          init    Initialize sshster configuration files inside of yours ~/.ssh dir
          compose Compile your projects to ~/.ssh/config file
          help    Show this help
        HELP
      end
    end
  end
end
# rubocop:enable all
