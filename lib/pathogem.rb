require 'pathogem/version'
require 'json'

module Pathogem
  MASTER_GEM_LIST = 'pathogem.sources'

  def self.install(gem_thingy)
    sources[gem_thingy]
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

  private
  
  def self.sources
    @sources ||= JSON.parse(File.read(MASTER_GEM_LIST))
  end
end
