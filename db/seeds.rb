require 'faker'

options = {}
options['account_name']  = ENV['DEMO_ACCOUNT_NAME'] || 'example'
options['company']       = ENV['DEMO_COMPANY'] || 'First Company'
options['email']         = ENV['DEMO_EMAIL'] || 'posko@example.com'
options['password']      = ENV['DEMO_PASSWORD'] || 'posko'
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
  property = {
    created_by: user,
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price(100..200, false),
    cost: Faker::Commerce.price(50..100, false),
    compare_at_price: Faker::Commerce.price(200..300, false),
    sku: sku.next!
  }
  service = ProductCreationService.new property
  service.perform

  option_type = service.product.option_types.create(name: 'Size')
  option_type.option_values.create(name: 'Small')
  option_type.option_values.create(name: 'Large')
  option_type = service.product.option_types.create(name: 'Color')
  option_type.option_values.create(name: 'Red')
  option_type.option_values.create(name: 'Blue')
end

Rails.logger.debug "\nCreating Customer:"
customer = account.customers.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)
Rails.logger.debug "\t#{customer.first_name} #{customer.last_name} is created"
