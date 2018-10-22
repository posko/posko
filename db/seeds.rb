require 'faker'

options = {}
options['account_name']  = ENV['DEMO_ACCOUNT_NAME'] || 'first_company'
options['company']       = ENV['DEMO_COMPANY'] || 'First Company'
options['email']         = ENV['DEMO_EMAIL'] || 'admin@first_company.com'
options['password']      = ENV['DEMO_PASSWORD'] || 'pass'
options['first_name']    = ENV['DEMO_FIRST_NAME'] || 'Juan'
options['last_name']     = ENV['DEMO_LAST_NAME'] || 'Dela Cruz'

Rails.logger.debug "\nSigning Up:"
@registration_form = RegistrationForm.new options
if @registration_form.save
  Rails.logger.debug "\t Created #{@registration_form.account.company}"
else
  Rails.logger.debug "\tSign Up Failed"
end

account = @registration_form.account
user = @registration_form.user
sku = '000000001'
100.times.each do |_x|
  title = Faker::Commerce.product_name
  product = account.products.create(title: title, created_by: user)
  2.times do |_y|
    var = {
      title: "#{Faker::Color.unique.color_name.titleize} #{title}",
      sku: sku.next!,
      price: Faker::Commerce.price(100..200, false),
      compare_at_price: Faker::Commerce.price(200..300, false),
      barcode: "B#{sku}"
    }
    product.variants.create(var)
  end
  Faker::Color.unique.clear
end

Rails.logger.debug "\nCreating Customer:"
customer = account.customers.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)
Rails.logger.debug "\t#{customer.first_name} #{customer.last_name} is created"
