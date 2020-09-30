class FeedbacksController < ApplicationController
  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      FeedbackMailer.with(id: @feedback.to_param)
                    .send_admin
                    .deliver_now

      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
