# in spec/calculator_spec.rb
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'pathogem/git'

describe Pathogem::Git do

  before do
    @git_url = 'http://github.com/foo/bar'
    @safe_shell_success = SafeShell.execute('true')
    @safe_shell_failed = SafeShell.execute('false')
  end

  it "clones the given github url" do
    SafeShell.should_receive(:execute).with('git', 'clone', @git_url).and_return(@safe_shell_success)
    Pathogem::Git.clone(@git_url)
  end

  it "clones the given github url to a specific location" do
    SafeShell.should_receive(:execute).with('git', 'clone', @git_url, 'destination').and_return(@safe_shell_success)
    Pathogem::Git.clone(@git_url, 'destination')
  end

  it "raises an error if the clone fails" do
    SafeShell.should_receive(:execute).with('git', 'clone', @git_url).and_return(@safe_shell_failed)
    expect {
      Pathogem::Git.clone(@git_url)
    }.to raise_error
  end
end
