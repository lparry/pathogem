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

  it 'complains if it doesnt get an argument' do
    expect {
      Pathogem.install(nil)
    }.to raise_error
  end

  it 'raises an error if it doenst know where to find a plugin' do
    expect {
      Pathogem.gem_source('sdlfjlaksjdflkasjdflksdjlkfjsald')
    }.to raise_error Pathogem::UnknownPlugin

  end

  end
end

