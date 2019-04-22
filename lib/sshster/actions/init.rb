module Sshster
  module Actions
    class Init < Base
      def run
        create_root_dir
        backup_config
        create_sshster_yml
        create_projects_dir
      end

      private

      def create_root_dir
        return if root_path.exist?

        FileUtils.mkdir_p(root_path)
      end

      def create_projects_dir
        return if projects_path.exist?

        FileUtils.mkdir(projects_path)
      end

      def create_sshster_yml
        return if sshster_config_path.exist?

        FileUtils.touch(sshster_config_path)
      end

      def backup_config
        return if origin_config_path.exist?

        if config_path.exist?
          FileUtils.mv(config_path, origin_config_path)
        else
          FileUtils.touch(origin_config_path)
        end
      end
    end
  end
end
