class BreadkoGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_layout
		template "breadkos_controller.erb", "app/controller/#{objects}_controller.rb"
  end

private

	def objects
		@objects ||= name.underscore.pluralize
	end

  def object
  	@object ||= objects.singularize
  end
end
