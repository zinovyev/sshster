module Sshster
  module Actions
    class Init < Base
      def run
        # create sshster.yml configuration file
        # backup origin configuration file
        # create projects directory if not exists
        binding.pry
      end
    end
  end
end
