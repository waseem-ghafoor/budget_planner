class PersonalAdvisorRequestMailer < ApplicationMailer
  # month end reminder
  def send_admin
    @advisor = PersonalAdvisorRequest.find(params[:id])

    mail(to: admin_email, subject: "Hi! I am #{@advisor.first_name}, a Personal Finance Advisor")
  end

  private

  def admin_email
    Rails.application.credentials[:email][:id]
  end
end
