$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../lib'))
require 'pathogem/manifest'

describe Pathogem::Manifest do

  before do
    @manifest_file = '/tmp/pathogem_manifest'
    Pathogem.stub :manifest_file => @manifest_file
    `rm -f '#{@manifest_file}'`
  end

  it 'should write to the mainfest file' do
    Pathogem::Manifest.add("banana")
    `cat '#{@manifest_file}'`.strip.should == "banana"
  end

  it 'should not write duplicates to the mainfest file' do
    Pathogem::Manifest.add("banana")
    Pathogem::Manifest.add("banana")
    `cat '#{@manifest_file}'`.strip.should == 'banana'
  end

  it 'should remove files from the manifest' do
    Pathogem::Manifest.add("banana")
    Pathogem::Manifest.add("apple")
    Pathogem::Manifest.add("orange")

    Pathogem::Manifest.remove("apple")

    `cat '#{@manifest_file}'`.strip.should == "banana\norange"
  end

  it 'should not raise errors if the file is already not in the manifest' do
    expect {
      Pathogem::Manifest.remove("apple")
    }.to_not raise_error
  end

  it 'should know whether or not pathogem was used to install the plugin' do
    Pathogem::Manifest.installed?("redcar").should be_false
    Pathogem::Manifest.add("redcar")
    Pathogem::Manifest.installed?("redcar").should be_true
  end
end
