json.user do
  json.email        @user.email
  json.first_name   @user.first_name
  json.last_name    @user.last_name
  json.token        @access_key.token
  json.auth_token   @access_key.auth_token
  json.created_at   @user.created_at
end
