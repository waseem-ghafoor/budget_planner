ActiveAdmin.register Plan do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :_id
  #
  # or
  #
  permit_params do
    permitted = [:_id, :name, :price, :paypal_plan_id]
  end
  
end
