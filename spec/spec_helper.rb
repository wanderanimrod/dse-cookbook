require 'chefspec'
require 'chefspec/berkshelf'
require_relative 'matchers/has_yaml_key'

at_exit { ChefSpec::Coverage.report! }
