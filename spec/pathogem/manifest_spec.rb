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
end
