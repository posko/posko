module Searchables
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      class_attribute :searchables, default: Array.new, instance_writer: false
      self.searchables = []

      private

      def filter_by_searchables
        self.searchables.each do |searchable|
          column = searchable.to_sym
          self.relation = relation.where(column => params[column]) if params[column].present?
        end
      end
    end
  end

  module ClassMethods
    def add_searchables(*args)
      self.searchables ||= []
      self.searchables += args
    end
  end
end
