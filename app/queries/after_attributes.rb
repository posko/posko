module AfterAttributes
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :after_attributes, default: [], instance_writer: false
      self.after_attributes = []

      private
      
      def filter_after_attributes
        self.after_attributes.each do |attribute|
          if params["after_#{attribute}".to_sym].present?
            filter_after attribute
          end
        end
      end
      def filter_after attribute
        self.relation = relation.where("#{attribute} > ?", params["after_#{attribute}".to_sym])
      end
    end
  end

  module ClassMethods
    def add_after_attributes(*args)
      self.after_attributes ||= []
      self.after_attributes += args
    end
  end
end
