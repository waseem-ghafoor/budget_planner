class Plan
  include Mongoid::Document
  field :name, type: String
  field :price, type: String
  field :paypal_plan_id, type: String
end
