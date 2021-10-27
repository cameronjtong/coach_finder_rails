class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user&.authenticated(:activation, params[:id])
      @user.update_attribute(:activated, true)
  end

  def update
    @user = User.find_by(:email, params[:email])
    if @user&.update(activation_params)
      flash[:success] = 'Account verified and created!'
      redirect_to root_url
    else
      flash[:danger] = 'Error, please try again or contact an admin'
      redirect_to root_url
    end
  end
end
