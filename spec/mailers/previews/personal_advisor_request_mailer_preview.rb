# Preview all emails at http://localhost:3000/rails/mailers
class PersonalAdvisorRequestMailerPreview < ActionMailer::Preview
  def send_admin
    PersonalAdvisorRequestMailer.with(id: PersonalAdvisorRequest.first.to_param).send_admin
  end
end
