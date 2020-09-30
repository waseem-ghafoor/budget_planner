class FeedbackMailer < ApplicationMailer
  # month end reminder
  def send_admin
    @feedback = Feedback.find(params[:id])

    mail(to: admin_email, subject: "Hi! You got a new feedback!")
  end

  private

  def admin_email
    Rails.application.credentials[:email][:id]
  end
end
