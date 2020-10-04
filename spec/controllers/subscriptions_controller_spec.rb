require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe "GET #get_subscription" do
    it "returns http success" do
      get :get_subscription
      expect(response).to have_http_status(:success)
    end
  end

end
