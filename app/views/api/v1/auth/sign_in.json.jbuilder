json.user do
  json.email        @user.email
  json.first_name   @user.first_name
  json.last_name    @user.last_name
  json.token        @user.access_keys.first.token
  json.auth_token   @user.access_keys.first.auth_token
  json.created_at   @user.created_at
end
