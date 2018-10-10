#!/usr/bin/env ruby
require 'pathname'
require 'fileutils'
include FileUtils

# path to your application root.
APP_ROOT = Pathname.new File.expand_path('..', __dir__)

def system!(*args)
  system(*args) || abort("\nCommand #{args} failed")
end

chdir APP_ROOT do
  puts "\nCopying sample files"
  unless File.exist?('config/database.yml')
    puts 'Copying database.yml'
    cp 'config/database.sample.yml', 'config/database.yml'
  end

  unless File.exist?('config/secrets.yml')
    puts 'Copying secrets.yml'
    cp 'config/secrets.sample.yml', 'config/secrets.yml'
  end
end
