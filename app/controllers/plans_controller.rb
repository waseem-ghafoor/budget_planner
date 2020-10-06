class PlansController < ApiController
  def index
  	render json: Plan.first(2)
  end

  def update
  end
end
