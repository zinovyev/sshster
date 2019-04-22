require 'bundler/setup'
require 'sshster'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.before(:all) do
    @home_env = ENV['HOME']
    ENV['HOME'] = '/home/example'
  end

  config.after(:all) do
    ENV['HOME'] = @home_env
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
