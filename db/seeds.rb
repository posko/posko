# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@sign_up = SignUp.new account_name: "first_company", company: "First Company", email: "admin@first_company.com", password: "mypassword",
  first_name: "Juan", last_name: "Dela Cruz"
if @sign_up.process
  puts "Sign Up success"
else
  puts "Sign Up Failed"
end
