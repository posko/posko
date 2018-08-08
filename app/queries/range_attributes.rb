module RangeAttributes
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :range_attributes, default: Array.new, instance_writer: false
      self.range_attributes = []

      private

      def filter_by_range_attributes
        self.range_attributes.each do |range_attribute|
          self.relation = attribute_max("#{range_attribute}_max") if params["#{range_attribute}_max".to_sym]
          self.relation = attribute_min("#{range_attribute}_min") if params["#{range_attribute}_min".to_sym]
        end
      end

      def attribute_min key
        # Calm down. column_name is whitelisted. check #add_range_attributes method
        column_name = key.to_s.gsub(/_min$/, "")
        relation.where("products.#{column_name} >= ?", params[key.to_sym])
      end

      def attribute_max key
        # Calm down. column_name is whitelisted. check #add_range_attributes method
        column_name = key.to_s.gsub(/_max$/, "")
        relation.where("products.#{column_name} <= ?", params[key.to_sym])
      end
    end
  end

  module ClassMethods
    def add_range_attributes(*args)
      self.range_attributes ||= []
      self.range_attributes += args
    end
  end
end
