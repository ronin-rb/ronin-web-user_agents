require 'rspec'
require 'simplecov'
require 'ronin/web/user_agents/version'

SimpleCov.start

RSpec.configure do |c|
  c.include(Ronin::Web)
end
