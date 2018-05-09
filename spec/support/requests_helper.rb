# spec/support/request_helpers.rb
module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end
  module AuthHelpers
    def basic_auth token, auth_token
      ActionController::HttpAuthentication::Basic.encode_credentials(token,auth_token)
    end
  end
end
