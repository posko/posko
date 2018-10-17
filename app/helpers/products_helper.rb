module ProductsHelper
  def selling_policy_options
    Variant.selling_policies.collect do |k, v|
      [k.humanize, k]
    end
  end
end
