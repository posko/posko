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

account = @sign_up.account
user = @sign_up.user
starting_products = [
  {
    title: "Bag",
    variants: [
      {
        title: "Green Bag",
        sku: "0001",
        price: 1000,
        compare_at_price: 1500,
        barcode: "00000001",
      },
      {
        title: "Blue Bag",
        sku: "0002",
        price: 950,
        compare_at_price: 1400,
        barcode: "00000002",
      }
    ]
  },
  {
    title: "Laptop",
    variants: [
      {
        title: "i7",
        sku: "0005",
        price: 31000,
        compare_at_price: 38000,
        barcode: "00000006",
      },
      {
        title: "i5",
        sku: "0006",
        price: 25000,
        compare_at_price: 30000,
        barcode: "00000007",
      }
    ]
  },

]
starting_products.each do |prod|
  product = account.products.create(title: prod[:title], created_by: user)
  prod[:variants].each do |var|
    product.variants.create(var)
  end
end
