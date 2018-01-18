json.user do
  json.email        @user.email
  json.token        @user.token
  json.created_at   @user.created_at
end
