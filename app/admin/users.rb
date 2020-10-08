ActiveAdmin.register User do
permit_params :email, subscription_attributes: [:id, :plan_name]
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
      f.input :email, input_html: { disabled: true } 
      f.inputs do
      f.fields_for :subscription  do |j|
        j.input :plan_name, as: :select, collection: [['Trial','Trial'], ['Free Plan','free_plan'], ['Plus Plan','plus_plan'], ['Prime Plan','prime_plan']]
      end
    end
      
      #f.input :subscription

    end
    f.actions
  end
    
  
end
