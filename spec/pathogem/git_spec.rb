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
    Pathogem::Git.clone(@git_url).should be_true
  end

  it "clones the given github url to a specific location" do
    SafeShell.should_receive(:execute).with('git', 'clone', @git_url, 'destination').and_return(@safe_shell_success)
    Pathogem::Git.clone(@git_url, 'destination').should be_true
  end

  it "raises an error if the clone fails" do
    SafeShell.should_receive(:execute).with('git', 'clone', @git_url).and_return(@safe_shell_failed)
    expect {
      Pathogem::Git.clone(@git_url)
    }.to raise_error
  end

  it "raises an error if the destination already exists" do
    File.should_receive(:exist?).with('dest').and_return(true)
    expect {
      Pathogem::Git.clone(@git_url, 'dest')
    }.to raise_error
  end

  context 'actually reading/writing to disk' do
    before :each do
      @git_dir = '/tmp/git_repo_specs'
      `rm -rf '#{@git_dir}'`
      `mkdir -p '#{@git_dir}'`
      `git init '#{@git_dir}'`
    end

    it 'should check for a .git directory to detemine if a folder is a git repo' do
      Pathogem::Git.is_a_git_repo?(@git_dir).should be_true
      Pathogem::Git.is_a_git_repo?('/').should be_false
    end

    it 'should be know if a repo is dirty' do
      Pathogem::Git.dirty?(@git_dir).should be_false
      `touch '#{File.join(@git_dir, "blah-di-dah.txt")}'`
      `git add '#{File.join(@git_dir, "blah-di-dah.txt")}'`
      Pathogem::Git.dirty?(@git_dir).should be_true
    end
  end
end
