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


    def self.dirty?(destination)
      `cd #{destination} && git status -s 2> /dev/null`.length != 0
    end

    def self.is_a_git_repo?(destination)
      File.directory?(File.join(destination, ".git"))
    end
  end
end
