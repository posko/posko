class ProductDecorator < Draper::Decorator
  delegate_all

  def title_link
    h.link_to title, self
  end
end
