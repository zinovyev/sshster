module Sshster
  module Actions
    class Compose < Base
      def run
        @host_names = []
        @projects = []
        compile_projects
        File.write(config_path, File.read(origin_config_path))
        open(config_path, 'a') do |f|
          f << "\n\n # === GENERATED === # \n\n"
          @projects.map do |project|
            compile_project(project, f)
            f << "\n\n"
          end
        end
      end

      private

      def compile_project(project, f)
        options = project[:options]
        screen_session = options['screen_session']
        f << "Host #{project[:name]}\n"
        f << "  ForwardAgent yes\n" if options['forward_agent']
        f << "  HostName #{project[:hostname]}\n"
        f << "  User #{options['user']}\n"
        f << "  RequestTTY yes\n" if options['request_tty']
        f << "  RemoteCommand ssh-agent ; ssh-add ; screen -SRR #{screen_session} &>/dev/null || bash --login\n" if screen_session
      end

      def parse_projects_data(projects_data, groups = [])
        if projects_data.is_a?(Hash)
          projects_data.each do |group, project|
            new_groups = groups.dup
            parse_projects_data(project, new_groups << group)
          end
        elsif projects_data.is_a?(Array)
          projects_data.map do |project|
            name = project.find { |_k, v| v.nil? }&.first
            options = project.select { |k, v| !v.nil? }.to_h
            @projects << prepare_project(name, groups, options)
          end
        end
      end

      def prepare_project(name, groups, options)
        { name: build_project_name(name, groups),
          hostname: name,
          options: build_project_options(options) }
      end

      def build_project_options(options)
        config.merge(options)
      end

      def build_project_name(name, groups)
        return name if groups.empty?
        name = groups.join('.')
        names_count = @host_names.select { |host| host == name }.count + 1
        @host_names << name
        "#{name}#{names_count}"
      end

      def compile_projects(groups = [])
        projects do |projects_data|
          parse_projects_data(projects_data, groups = [])
        end
      end

      def projects
        projects_paths.each do |project_path|
          data = parse_project(project_path)
          hosts = data['hosts'] if data
          yield(hosts) if hosts
        end
      end

      def parse_project(file_path)
        YAML.safe_load(File.read(file_path))
      end

      def projects_paths
        Dir[projects_path.join('*.yml')]
      end
    end
  end
end
