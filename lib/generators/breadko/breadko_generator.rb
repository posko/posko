class BreadkoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  class_option :with_datatable, type: :boolean, default: false, description: 'Add datatable'

  argument :attributes, type: :array, default: []

  # I can't make it work.
  # hook_for :orm
  def generate_layout
    generate_app_classes

    generate_views

    generate_specs
    generate_additional_classes
  end

  def generate_app_classes
    template 'breadkos_controller.erb', "app/controllers/#{objects}_controller.rb"
    template 'breadko_model.erb', "app/models/#{object}.rb"
  end

  def generate_views
    template 'views/index.html.erb', "app/views/#{objects}/index.html.erb"
    template 'views/show.html.erb', "app/views/#{objects}/show.html.erb"
    template 'views/new.html.erb', "app/views/#{objects}/new.html.erb"
    template 'views/_actions.html.erb', "app/views/#{objects}/_actions.html.erb"
    template 'views/edit.html.erb', "app/views/#{objects}/edit.html.erb"
  end

  def generate_specs
    template 'breadkos_controller_spec.erb', "spec/controllers/#{objects}_controller_spec.rb"
    template 'breadko_model_spec.erb', "spec/models/#{object}_spec.rb"
    template 'breadkos_factory.erb', "spec/factories/#{objects}.rb"
  end

  def generate_additional_classes
    template 'breadko_datatable.erb', "app/datatables/#{object}_datatable.rb" if with_datatable?
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
