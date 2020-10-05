class SubscriptionsController < ApiController
  before_action :set_subscription, except: :get_subscription
  
  def get_subscription
    render json: current_user.subscription
  end

  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

 private

  def set_subscription
    @subscription = current_user.subscription
  end

  def subscription_params
    params.require(:subscription).permit(
      :paypal_subscription_id,
      :plan_name
    )
  end
end