module Pathogem
  module Git
    def self.clone(repo, dest = nil)
      output = if dest
        SafeShell.execute('git', 'clone', repo, dest)
      else
        SafeShell.execute('git', 'clone', repo)
      end
      raise "somethings fucked" unless output.succeeded?
    end
  end
end
