require 'safe_shell'

module Pathogem
  module Git
    class CloneFailed < RuntimeError; end
    class DestinationAlreadyExists < RuntimeError; end

    def self.clone(repo, destination = nil)
      output = if destination
        raise DestinationAlreadyExists.new if File.exist?(destination)
        SafeShell.execute('git', 'clone', repo, destination)
      else
        SafeShell.execute('git', 'clone', repo)
      end
      raise CloneFailed.new unless output.succeeded?
      true
    end
  end
end
