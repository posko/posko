class BreadkoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  class_option :with_datatable, type: :boolean, default: false, description: "Add datatable"

  argument :attributes, type: :array, default: []
  def generate_layout
    template "breadkos_controller.erb", "app/controllers/#{objects}_controller.rb"
    template "breadko_model.erb", "app/models/#{object}.rb"

    template "breadkos_controller_spec.erb", "spec/controllers/#{objects}_controller_spec.rb"
    template "breadko_model_spec.erb", "spec/models/#{object}_spec.rb"
		template "breadkos_factory.erb", "spec/factories/#{objects}.rb"
    if with_datatable?
      template "breadko_datatable.erb", "app/datatables/#{object}_datatable.rb"
    end
  end

private

	def objects
		@objects ||= name.underscore.pluralize
	end

  def object
  	@object ||= objects.singularize
  end
  def with_datatable?
		options.with_datatable.present?
  end
end
