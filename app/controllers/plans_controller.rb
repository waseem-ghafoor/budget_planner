class PlansController < ApiController
  def index
  	render json: Plan.all
  end

  def update
  end
end
