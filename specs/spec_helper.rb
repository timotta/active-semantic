ENV["RAILS_ENV"] = 'test'

require 'spec/autorun'
require File.join(File.dirname(__FILE__), '../lib/active_semantic')
#require 'spec/rails'

Spec::Runner.configure do |config|
end