require 'safe_shell'

module Pathogem
  module Git
    class CloneFailed < RuntimeError; end
    class DestinationAlreadyExists < RuntimeError; end
    class NotAGitRepo < RuntimeError; end
    class RepoDirty < RuntimeError; end
    class RebaseFailed < RuntimeError; end

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

    def self.update(destination)
      raise NotAGitRepo.new unless is_a_git_repo?(destination)
      raise RepoDirty.new if dirty?(destination)
      fetch_origin(destination)
      if head_changed?(destination)
        rebase_origin(destination)
        true
      else
        false
      end
    end

    def self.cd(directory)
      old_directory = Dir.getwd
      Dir.chdir(directory)
      yield
    ensure
      Dir.chdir(old_directory)
    end

    def self.rebase_origin(destination, branch_name = 'master')
      cd(destination) do
        unless SafeShell.execute?('git', 'rebase', '-p', "origin/#{branch_name}")
          SafeShell.execute?('git', 'rebase', '--abort')
          raise RebaseFailed.new "failed to rebase #{destination} onto origin/#{branch_name}, aborted... plzfixme?"
        end
      end
    end

    def self.fetch_origin(destination)
      SafeShell.execute?('git', 'fetch', 'origin')
    end

    def self.head_changed?(destination)
      cd (destination) do
        SafeShell.execute("git log HEAD..origin/master | grep '^commit'|wc -l").to_i != 0
      end
    end

    def self.dirty?(destination)
      `cd '#{destination}' && git status -s 2> /dev/null`.length != 0
    end

    def self.is_a_git_repo?(destination)
      File.directory?(File.join(destination, ".git"))
    end
  end
end
