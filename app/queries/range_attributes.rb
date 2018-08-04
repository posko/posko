module RangeAttributes
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :range_attributes, default: Array.new, instance_writer: false
    end
  end

  module ClassMethods
    def add_range_attributes(*args)
      self.range_attributes ||= []
      self.range_attributes += args
    end
  end
end
