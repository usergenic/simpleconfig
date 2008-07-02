ENV['LOG_NAME'] = 'spec'

$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end

require 'simpleconfig'
