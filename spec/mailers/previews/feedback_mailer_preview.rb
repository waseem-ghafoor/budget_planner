# Preview all emails at http://localhost:3000/rails/mailers
class FeedbackMailerPreview < ActionMailer::Preview
  def send_admin
    FeedbackMailer.with(id: Feedback.first.to_param).send_admin
  end
end
