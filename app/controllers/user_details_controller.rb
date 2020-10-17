class UserDetailsController < ApiController
  before_action :set_user

  def show
    render json: @user
  end

  def update
    if @user.valid_password?(params[:user_existing_password]) == false
      render json: { message: "Wrong current password." }, status: :forbidden
      return
    end
    
    @user.password = params[:user_new_password] if params[:user_new_password].present?
    @user.password_confirmation = params[:user_confirm_password] if params[:user_new_password].present?
    @user.skip_confirmation! if params[:user_email] != @user.email
    @user.skip_reconfirmation! if params[:user_email] != @user.email
    @user.email = params[:user_email] if params[:user_email] != @user.email
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def update_params
    user_detail_params = {}
    user_detail_params.merge!({email: params[:user_email]}) if params[:user_email].present?
    user_detail_params.merge!({password: params[:user_new_password], password_confirmation: params[:user_confirm_password] }) if params[:user_new_password].present?
    return user_detail_params
  end
end