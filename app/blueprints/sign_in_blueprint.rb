class SignInBlueprint < Blueprinter::Base
  association :user, blueprint: UserBlueprint, default: {}
  association :access_key, blueprint: AccessKeyBlueprint, default: {}
end
