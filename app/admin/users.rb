ActiveAdmin.register User do
permit_params :email, :password, user_access_attributes: [:id, :plan]
  
  index do
    selectable_column
    id_column
    column :email
    column :phone_number
    column :phone_pin
    column :phone_verified
    column 'plan' do |user|
      user.user_access.plan
    end
    column 'subscription_id' do |user|
      user.user_access.paypal_subscription_id
    end
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email 
      f.inputs do
        f.fields_for :user_access  do |j|
          j.input :plan, as: :select, collection: [ ['Free Plan', :free], ['Plus Plan', :plus], ['Prime Plan', :prime]]
        end
      f.input :password
      end
     
    end
    f.actions
  end
  
  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      if params[:user][:email].blank?
        params[:user].delete("email")
        params[:user].delete("email_confirmation")
      end
      super
    end
  end
  
  before_save do |user|
    user.skip_confirmation!
    user.skip_reconfirmation!
  end  
  
end