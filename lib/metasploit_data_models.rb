#
# Core
#
require 'shellwords'

#
# Gems
#
# gems must load explicitly any gem declared in gemspec
# @see https://github.com/bundler/bundler/issues/2018#issuecomment-6819359
#
#
require 'active_record'
require 'active_support'
require 'active_support/all'
require 'metasploit/concern'
require 'metasploit/model'
require 'arel-helpers'

#
# Project
#

require 'metasploit_data_models/base64_serializer'
require 'metasploit_data_models/serialized_prefs'
require 'metasploit_data_models/version'

autoload :Mdm, 'mdm'

module MetasploitDataModels
  extend ActiveSupport::Autoload

  autoload :AutomaticExploitation
  autoload :ModuleRun
  autoload :Search

  def self.root
    unless instance_variable_defined? :@root
      lib_pathname = Pathname.new(__FILE__).dirname

      @root = lib_pathname.parent
    end

    @root
  end
end

