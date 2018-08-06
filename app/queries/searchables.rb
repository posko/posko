module Searchables
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :searchables, default: Array.new, instance_writer: false
    end
  end

  module ClassMethods
    def add_searchables(*args)
      self.searchables ||= []
      self.searchables += args
    end
  end
end
