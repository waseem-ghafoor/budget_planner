ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :_id, :email, :encrypted_password, :sign_in_count, :deleted_at, :phone_verified
  #
  # or
  #
  # permit_params do
  #   permitted = [:_id, :email, :encrypted_password, :sign_in_count, :deleted_at, :phone_verified]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :phone_number
    column :phone_pin
    column :phone_verified
    column 'plan' do |user|
      user.subscription.plan_name
    end
    column 'subscription_id' do |user|
      user.subscription.paypal_subscription_id
    end

    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.inputs "Plan" do
      f.fields_for :subscription do |j|
        j.inputs :plan_name
      end
    end

    end
    f.actions
  end
    
  
end
