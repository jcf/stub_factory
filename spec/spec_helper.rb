$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'stub_factory'
require 'rspec'

include StubFactory

Rspec.configure do |config|
end
