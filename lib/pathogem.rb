require 'pathogem/version'
require 'pathogem/git'
require 'pathogem/manifest'
require 'pathogem/help'
require 'json'
require 'safe_shell'
require 'fileutils'

module Pathogem
  class NoArgumentError < RuntimeError; end
  class UnknownPlugin < RuntimeError; end
  class NotInfected < RuntimeError; end
  VIM_PLUGIN_DIR = File.expand_path("~/.vim/bundle/")
  NAME = 'pathogem'
  MASTER_PLUGIN_LIST = File.expand_path(File.join(File.dirname(__FILE__), "../config/#{NAME}.sources"))

  def self.manifest_file
    File.join(VIM_PLUGIN_DIR, ".#{NAME}")
  end

  # Install a plugin
  def self.install(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    Git.clone(plugin_source(plugin_name), destination(plugin_name))
    Manifest.add(plugin_name)
    puts "Successfully installed '#{plugin_name}'"
  rescue Git::DestinationAlreadyExists => e
    puts "'#{plugin_name}' already appears to be installed, perhaps you'd like to '#{NAME} update #{plugin_name}'"
    false
  end

  # Update a plugin that we installed
  def self.update(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    raise NotInfected unless Manifest.installed?(plugin_name)
    if Git.update(destination(plugin_name))
      puts "Successfully updated '#{plugin_name}'"
    else
      puts "No updates were found for '#{plugin_name}'"
    end
  rescue Pathogem::Git::NotAGitRepo => e
    puts "'#{plugin_name}' does not appear to be a git repository."
  rescue NotInfected => e
    puts "The '#{plugin_name}' plugin is either not installed or was not installed with #{NAME}"
  rescue Git::RepoDirty => e
    puts "Your copy of #{plugin_name} appears to have local modifications. Please commit or discard them and try again."
  end

  # Remove a plugin only if we installed using pathogem
  def self.uninstall(plugin_name)
    raise NoArgumentError if plugin_name.nil?
    Manifest.remove(plugin_name)
    nuke(plugin_name)
  end

  # Remove a plugin regardless of how it got installled
  def self.nuke(plugin_name)
    FileUtils.rm_rf(destination(plugin_name))
    puts "Successfully uninstalled '#{plugin_name}'"
    true
  end

  # List out all of the plugins installed on this machines
  def self.list
    puts Manifest.all.sort.unshift("Plugins installed through #{NAME}:").join("\n - ")
  end

  # List out all of the plugins that we know how to install
  def self.search
    puts sources.keys.sort.unshift("Plugins available through #{NAME}:").join("\n - ")
  end

  def self.update_all
    Manifest.all.each do |plugin|
      update(plugin)
    end
  end

  def self.destination(plugin_name)
    File.join(VIM_PLUGIN_DIR, plugin_name)
  end

  def self.plugin_source(plugin_name)
    sources[plugin_name] or raise UnknownPlugin.new("Unable to find #{plugin_name} within #{NAME} sources")
  end

  private

  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_PLUGIN_LIST))
  end
end
