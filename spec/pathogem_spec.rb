# in spec/calculator_spec.rb
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'pathogem'

describe Pathogem, "install" do
  before do
    @git_url = 'http://github.com/foo/bar'
  end
  it "looks up gems in it's master list" do
    File.should_receive(:read).and_return(%Q({"blah":"#{@git_url}"}))
    Pathogem.gem_source('blah').should == "http://github.com/foo/bar"
  end

  it Pathogem::Git, "checks out the given github url" do
    SafeShell.should_receive(:execute).with('git', 'checkout', @git_url)
    Pathogem::Git.checkout(@git_url)
  end

  it Pathogem::Git, "checks out the given github url to a specific location" do
    SafeShell.should_receive(:execute).with('git', 'checkout', @git_url, 'destination')
    Pathogem::Git.checkout(@git_url, 'destination')
  end
end

