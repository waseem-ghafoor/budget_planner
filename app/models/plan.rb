class Plan
  include Mongoid::Document
  field :name, type: String
  field :price, type: String
  field :paypal_plan_id, type: String
  after_update :after_plan_price_change

  def after_plan_price_change
    begin
      if paypal_plan_id.present?
        paypal = Paypal.new
        paypal.update_plan_price(paypal_plan_id, price)
      end
    rescue Exception => error
      p error.message
    end
  end

end