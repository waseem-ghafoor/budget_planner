class PlansController < ApiController
  def index
  	render json: Plan.first(3).pluck(:name, :price)
  end

  def update
  end
end
