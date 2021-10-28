class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user&.authenticated?(:activation, params[:id])
      @user.update_attribute(:activated, true)
    else
      flash[:danger] = 'Invalid link'
      redirect_to root_url
    end
  end

  def update
    @user = User.find_by(:email, params[:email])
    if @user
      update_attribute(expertise_ids:, params[:user][:expertise_ids:[]])
      flash[:success] = 'Account verified and created!'
      redirect_to root_url
    else
      flash[:danger] = 'Error, please try again or contact an admin'
      redirect_to root_url
    end
  end

  private

  # def activation_params
  #   params.require(:user).permit(expertise_ids:[])
  # end
end
