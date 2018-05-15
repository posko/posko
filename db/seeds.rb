# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
options = {}
options["account_name"]  = ENV["DEMO_ACCOUNT_NAME"] || "first_company"
options["company"]       = ENV["DEMO_COMPANY"] || "First Company"
options["email"]         = ENV["DEMO_EMAIL"] || "admin@first_company.com"
options["password"]      = ENV["DEMO_PASSWORD"] || "pass"
options["first_name"]    = ENV["DEMO_FIRST_NAME"] || "Juan"
options["last_name"]     = ENV["DEMO_LAST_NAME"] || "Dela Cruz"

@sign_up = SignUp.new options
if @sign_up.process
  puts "Sign Up success"
else
  puts "Sign Up Failed"
end
