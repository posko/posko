require 'generator_spec'
require 'rails_helper'
require 'generators/breadko/breadko_generator.rb'
RSpec.describe BreadkoGenerator, type: :generator do
  destination File.expand_path('../tmp', __dir__)
  arguments %w[posts content:string tags:string --with-datatable]

  before do
    prepare_destination
    run_generator
  end

  after do
    system 'rm -rf spec/tmp'
  end

  it 'creates a test initializer' do
    assert_file 'app/controllers/posts_controller.rb'
    assert_file 'app/datatables/post_datatable.rb'
    assert_file 'app/models/post.rb'

    assert_file 'app/views/posts/index.html.erb'
    assert_file 'app/views/posts/show.html.erb'
    assert_file 'app/views/posts/new.html.erb'
    assert_file 'app/views/posts/_actions.html.erb'
    assert_file 'app/views/posts/edit.html.erb'

    assert_file 'spec/controllers/posts_controller_spec.rb'
    assert_file 'spec/models/post_spec.rb'
    assert_file 'spec/factories/posts.rb'
  end
end
