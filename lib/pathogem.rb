require 'pathogem/version'
require 'pathogem/git'
require 'json'
require 'safe_shell'

module Pathogem
  VIM_GEM_DIR = File.expand_path("~/.vim/pathogem/")
  MASTER_GEM_LIST = File.expand_path(File.join(File.dirname(__FILE__), '../pathogem.sources'))

  def self.install(gem_name)
    Git.clone(gem_source(gem_name), destination(gem_name))
  rescue Git::DestinationAlreadyExists => e
    puts "'#{gem_name}' already appears to be installed, perhaps you'd like to 'pathogem update #{gem_name}'"
    false
  end

  def self.uninstall(gem_name)
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
    sources[gem_name]
  end

  private
  
  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_GEM_LIST))
  end
end
