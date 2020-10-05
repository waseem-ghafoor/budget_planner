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
  
end
