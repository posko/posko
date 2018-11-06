module ProductsHelper
  def selling_policy_options
    Variant.selling_policies.collect do |k, _v|
      [k.humanize, k]
    end
  end

  def category_options
    options = Category.all.collect do |category|
      [category.name, { data: { directory: category.directory } }, category.id]
    end
    options_for_select options
  end
end
