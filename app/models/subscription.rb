class Subscription
  include Mongoid::Document
  field :paypal_subscription_id, type: String
  field :plan_name, type: String, default: "Trial"
  embedded_in :user
  after_update :after_plan_change

  PLUS_PLAN_ID , PRIME_PLAN_ID = Plan.first(2).pluck(:paypal_plan_id) 
  
  def after_plan_change
    begin
      paypal = Paypal.new
      if paypal_subscription_id.present? && plan_name == 'free_plan'
        paypal.cancel_subscription(paypal_subscription_id)
        set(paypal_subscription_id: nil)
      else
        subscription_plan = paypal.current_subscription_plan(paypal_subscription_id)  
        unless subscription_plan == get_active_plan_id
          paypal.update_subscritpion(paypal_subscription_id, get_active_plan_id)
        end
      end
    rescue Exception => error
      p error.message
    end
  end

  private
  def get_active_plan_id
    return PLUS_PLAN_ID if plan_name == 'plus_plan'
    return PRIME_PLAN_ID if plan_name == 'prime_plan'
  end
end