class MerchantSailsCountSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant_count_revenue
  attributes :count, :name

end
