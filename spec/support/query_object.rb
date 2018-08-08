module QueryObjectHelpers
  module Matchers
    RSpec::Matchers.define :range_filter_for do |expected|
      match do |actual|
        actual.range_attributes.include? expected
      end
    end
    
    RSpec::Matchers.define :have_searchable do |expected|
      match do |actual|
        actual.searchables.include? expected
      end
    end
  end
end
