class UserDecorator < Draper::Decorator
  delegate_all

  def name
    fullname = []
    fullname << first_name
    fullname << last_name
    fullname << suffix if suffix
    fullname.join(" ")
  end

end
