require 'net/http'
require 'uri'
#Need to remove this for better sol.
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class Paypal
  CLIENT_ID = Rails.application.credentials[:PAYPAL_CLIENT_ID]
  CLIENT_SECRET = Rails.application.credentials[:PAYPAL_CLIENT_SECRET]
  
  def update_subscritpion(subscription_id, plan_id)
    url = "https://api.sandbox.paypal.com/v1/billing/subscriptions/#{subscription_id}/revise"
    response = RestClient::Request.execute(method: :post, url: url ,payload: new_plan_param(plan_id).to_json , headers: headers)
  end

  def update_plan_price(plan_id, new_price)
    url = "https://api.sandbox.paypal.com/v1/billing/plans/#{plan_id}/update-pricing-schemes"
    response = RestClient::Request.execute(method: :post, url: url ,payload: new_price_param(new_price).to_json , headers: headers)
  end

  def cancel_subscription(subscription_id, msg = nil)
    url = "https://api.sandbox.paypal.com/v1/billing/subscriptions/#{subscription_id}/cancel"
    response = RestClient::Request.execute(method: :post, url: url ,payload: subscriptions_cancel_msg(msg).to_json , headers: headers)
  end
  def current_subscription_plan(subscription_id)
    url = "https://api.sandbox.paypal.com/v1/billing/subscriptions/#{subscription_id}"
    response = RestClient::Request.execute(method: :get, url: url, headers: headers)
    parser_data_plan_id(response)
  end

  private
  def subscriptions_cancel_msg(msg = nil)
    default_msg = 'Not satisfied with the service'
    {'reason': msg.nil? ? default_msg : msg}
  end
  def headers
    {content_type: :'application/json', Authorization: "#{basic_auth}"}
  end
  def new_plan_param plan_id
    {"plan_id" => "#{plan_id}"}
  end
  def new_price_param new_price
    {
      "pricing_schemes": [{
        "billing_cycle_sequence": 1,
        "pricing_scheme": {
          "fixed_price": {
            "value": new_price.to_s,
            "currency_code": "USD"
            }
          }
      }]
    }
  end
  def fetch_token
    p @authorization_token
  end
  def parse_access_token_data(response)
    JSON.parse(response.body).extract!("access_token")["access_token"]  
  end
  def parser_data_plan_id(response)
    JSON.parse(response.body).extract!("plan_id")['plan_id']
  end
  def basic_auth
    "Basic "+ convert_base_64(CLIENT_ID+':'+CLIENT_SECRET)
  end
  def convert_base_64 str
    Base64.encode64(str).gsub("\n", '')
  end  
end