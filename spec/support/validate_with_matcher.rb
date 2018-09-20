# Author: bartuz
# RSpec matcher for validates_with.
# https://gist.github.com/2032846
# Usage:
#
#     describe User do
#       it { should validate_with CustomValidator }
#     end
RSpec::Matchers.define :validate_with do |expected_validator, _options|
  match do |subject|
    @validator = subject.class.validators.find do |validator|
      validator.class == expected_validator
    end
    @validator.present? && options_matching?
  end

  def options_matching?
    if @options.present?
      @options.all? { |option| @validator.options[option] == @options[option] }
    else
      true
    end
  end

  chain :with_options do |options|
    @options = options
  end

  description do
    'RSpec matcher for validates_with'
  end

  failure_message do |_text|
    "expected to validate with #{validator}#{@options.present? ? (' with options ' + @options) : ''}"
  end

  failure_message_when_negated do |_text|
    "do not expected to validate with #{validator}#{@options.present? ? (' with options ' + @options) : ''}"
  end
end
