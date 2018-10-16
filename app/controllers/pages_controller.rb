class PagesController < ApplicationController
  def dashboard
    @users = current_account.users
    @invoices = current_account.invoices
    @products = current_account.products
    @variants = current_account.variants
  end
end
