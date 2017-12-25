class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  enum status: [:active, :deleted], _suffix: true
end
