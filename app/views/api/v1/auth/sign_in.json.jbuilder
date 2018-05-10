json.user do
  json.email        @user.email
  json.token        @user.access_keys.first.token
  json.auth_token   @user.access_keys.first.auth_token
  json.created_at   @user.created_at
end
