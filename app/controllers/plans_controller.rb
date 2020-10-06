class PlansController < ApiController
  def index
  	render json: Plan.first(2).pluck(:name, :price)
  end

  def update
  end
end
