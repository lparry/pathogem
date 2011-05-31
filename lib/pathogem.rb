require 'pathogem/version'
require 'json'
require 'safe_shell'

module Pathogem
  MASTER_GEM_LIST = File.join(File.dirname(__FILE__), 'pathogem.sources')

  def self.install(gem_thingy)
  end

  def self.uninstall(gem_thingy)
  end

  def self.update(gem_thingy)
  end

  def self.help_message
    <<-HELP
Oh snap, you ran this before I got round to sorting out help. I guess you'll have to dig into the source.
    HELP
  end

  def self.gem_source(gem_name)
    sources[gem_name]
  end

  private
  
  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_GEM_LIST))
  end
end
