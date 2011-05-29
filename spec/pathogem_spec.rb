# in spec/calculator_spec.rb
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
require 'pathogem'

describe Pathogem, "install" do
  it "looks up gems in it's master list" do
    File.should_receive(:read).and_return('{"blah":"http://github.com/foo/bar"}')
    Pathogem.install('blah')
  end

end
