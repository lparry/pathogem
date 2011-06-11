$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'pathogem'

describe Pathogem, "install" do
  before do
    @git_url = 'http://github.com/foo/bar'
  end

  it "looks up plugins in it's master list" do
    File.should_receive(:read).and_return(%Q({"blah":"#{@git_url}"}))
    Pathogem.plugin_source('blah').should == "http://github.com/foo/bar"
  end

  it 'complains if it doesnt get an argument' do
    expect {
      Pathogem.install(nil)
    }.to raise_error
  end

  it 'raises an error if it doenst know where to find a plugin' do
    expect {
      Pathogem.plugin_source('sdlfjlaksjdflkasjdflksdjlkfjsald')
    }.to raise_error Pathogem::UnknownPlugin
  end

  it "clones the git repo and adds the plugin to the manifest" do
    Pathogem.stub :plugin_source => 'plugin_name'
    Pathogem::Manifest.should_receive(:add).with('plugin_name')
    Pathogem::Git.should_receive(:clone).with('plugin_name', File.expand_path("~/.vim/pathogem/plugin_name"))
    Pathogem.install 'plugin_name'
  end

  it "clones the git repo and adds the plugin to the manifest" do
    Pathogem.stub :plugin_source => 'plugin_name'
    Pathogem::Manifest.should_receive(:remove).with('plugin_name')
    FileUtils.stub :rm_rf => true
    Pathogem.uninstall 'plugin_name'
  end

  it "should check if a plugin was installed with pathogem before updating" do
    expect {
      Pathogem.update "lkasjdflkjasdofjasdofjsld"
    }.to raise_error Pathogem::NotInfected
  end

  it "should check if a plugin was installed with pathogem before updating" do
    Pathogem::Manifest.should_receive(:installed?).and_return(true)
    Pathogem::Git.should_receive(:update).with(File.expand_path('~/.vim/pathogem/gem_name'))
    Pathogem.update "gem_name"
  end

  it "should attempt to update all plugins from the manifest"

end

