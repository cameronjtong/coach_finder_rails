class AccountActivationsController < ApplicationController
  def edit
  end

  def update
    @user = User.find_by(:email, params[:email])
    if @user&.authenticated?(:activation, params[:id])
      if @user&.update_attribute(:expertise_ids, activation_params)
      flash[:success] = 'Account verified and created!'
      @user.update_attribute(:activated, true)
      redirect_to root_url
    end
    else
      flash[:danger] = 'Error, please try again or contact an admin'
      redirect_to root_url
    end
  end

  private

  def activation_params
    params.require(:user).permit(expertise_ids: [])
  end
end
