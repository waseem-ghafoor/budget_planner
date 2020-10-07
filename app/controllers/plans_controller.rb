class PlansController < ApiController
  skip_before_action :authenticate_user!
  
  def index
    render json: Plan.all
  end

  def update
  end
end
