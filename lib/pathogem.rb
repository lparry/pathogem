require 'pathogem/version'
require 'pathogem/git'
require 'json'
require 'safe_shell'
require 'fileutils'

module Pathogem
  class NoArgumentError < RuntimeError; end
  class UnknownPlugin < RuntimeError; end
  VIM_GEM_DIR = File.expand_path("~/.vim/pathogem/")
  MASTER_GEM_LIST = File.expand_path(File.join(File.dirname(__FILE__), '../config/pathogem.sources'))

  def self.manifest_file
    File.expand_path("~/.pathogem")
  end

  def self.install(gem_name)
    raise NoArgumentError if gem_name.nil?
    Git.clone(gem_source(gem_name), destination(gem_name))
  rescue Git::DestinationAlreadyExists => e
    puts "'#{gem_name}' already appears to be installed, perhaps you'd like to 'pathogem update #{gem_name}'"
    false
  end

  def self.uninstall(gem_name)
    FileUtils.rm_rf(destination(gem_name))
    true
  end

  def self.update(gem_name)
  end

  def self.help_message
    <<-HELP
Oh snap, you ran this before I got round to sorting out help. I guess you'll have to dig into the source.
    HELP
  end

  def self.destination(gem_name)
    File.join(VIM_GEM_DIR, gem_name)
  end

  def self.gem_source(gem_name)
    sources[gem_name] or raise UnknownPlugin.new("Unable to find #{gem_name} within pathogem sources")
  end

  private

  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_GEM_LIST))
  end
end
