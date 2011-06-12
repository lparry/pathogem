module Pathogem
  module Help
    def self.usage
      <<-HELP
Oh snap, you ran this before I got round to sorting out help. I guess you'll have to dig into the source. Or you could try one of the following
  pathogem install plugin
  pathogem update plugin
  pathogem update --all
  pathogem uninstall plugin
  pathogem list
  pathogem search
      HELP
    end
  end
end
