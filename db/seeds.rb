# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

options = {}
options["account_name"]  = ENV["DEMO_ACCOUNT_NAME"] || "first_company"
options["company"]       = ENV["DEMO_COMPANY"] || "First Company"
options["email"]         = ENV["DEMO_EMAIL"] || "admin@first_company.com"
options["password"]      = ENV["DEMO_PASSWORD"] || "pass"
options["first_name"]    = ENV["DEMO_FIRST_NAME"] || "Juan"
options["last_name"]     = ENV["DEMO_LAST_NAME"] || "Dela Cruz"

puts "\nSigning Up:"
@registration_form = RegistrationForm.new options
if @registration_form.save
  puts "\t Created #{@registration_form.account.company}"
else
  puts "\tSign Up Failed"
end

account = @registration_form.account
user = @registration_form.user
sku = "000001"
3.times.each do |x|
  title = Faker::Commerce.product_name
  product = account.products.create(title: title, created_by: user)
  2.times do |y|
    var = {
      title: "#{Faker::Color.unique.color_name.titleize} #{title}",
      sku: sku.next!,
      price: Faker::Commerce.price(range = 100..200, as_string = false),
      compare_at_price: Faker::Commerce.price(range = 200..300, as_string = false),
      barcode: "B#{sku}"
    }
    product.variants.create(var)
  end
  Faker::Color.unique.clear
end

puts "\nCreating Customer:"
customer = account.customers.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)
puts "\t#{customer.first_name} #{customer.last_name} is created"
