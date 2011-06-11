require 'pathogem/version'
require 'pathogem/git'
require 'pathogem/manifest'
require 'json'
require 'safe_shell'
require 'fileutils'

module Pathogem
  class NoArgumentError < RuntimeError; end
  class UnknownPlugin < RuntimeError; end
  class NotInfected < RuntimeError; end
  VIM_PLUGIN_DIR = File.expand_path("~/.vim/pathogem/")
  MASTER_PLUGIN_LIST = File.expand_path(File.join(File.dirname(__FILE__), '../config/pathogem.sources'))

  def self.manifest_file
    File.expand_path("~/.pathogem")
  end

  def self.install(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    Git.clone(plugin_source(plugin_name), destination(plugin_name))
    Manifest.add(plugin_name)
    puts "Successfully installed '#{plugin_name}'"
  rescue Git::DestinationAlreadyExists => e
    puts "'#{plugin_name}' already appears to be installed, perhaps you'd like to 'pathogem update #{plugin_name}'"
    false
  end

  def self.uninstall(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    Manifest.remove(plugin_name)
    FileUtils.rm_rf(destination(plugin_name))
    true
  end

  def self.update(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    raise NotInfected.new('This plugin is either not installed or was not installed with pathogem') unless Manifest.installed?(plugin_name)
    Git.update(destination(plugin_name))
  end

  def self.help_message
    <<-HELP
Oh snap, you ran this before I got round to sorting out help. I guess you'll have to dig into the source.
    HELP
  end

  def self.destination(plugin_name)
    File.join(VIM_PLUGIN_DIR, plugin_name)
  end

  def self.plugin_source(plugin_name)
    sources[plugin_name] or raise UnknownPlugin.new("Unable to find #{plugin_name} within pathogem sources")
  end

  private

  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_PLUGIN_LIST))
  end
end
