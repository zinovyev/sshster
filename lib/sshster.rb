require 'pry'
require 'sshster/version'
require 'sshster/argv_parser'
require 'sshster/config'
require 'sshster/app'

module Sshster
  extend self
  class Error < StandardError; end

  def run(argv)
    options = ArgvParser.new(argv).parse
    App.new(options).run
  end
end
