module ProductsHelper
  def selling_policy_options
    Variant.selling_policies.collect do |k, _v|
      [k.humanize, k]
    end
  end
end
