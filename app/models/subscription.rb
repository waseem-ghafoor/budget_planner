class Subscription
  include Mongoid::Document
  field :paypal_subscription_id, type: String
  field :plan_name, type: String, default: "Trial"
  embedded_in :user
end
