class AccountSettingBlueprint < Blueprinter::Base
  identifier :id

  fields :tax_feature, :shifts_feature, :discounts_feature

  association :account, blueprint: AccountBlueprint, default: {}
end
