class AccountActivationsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[:edit update]

  def edit
  end

  def update
      if @user.update_attribute(:expertise_ids, params[:user][:expertise_ids])
        flash[:success] = 'Account verified and created!'
        @user.update_attribute(:activated, true)
        redirect_to root_url
      else
        flash[:danger] = 'Activation failed, contact an admin!'
        redirect_to root_url
    end
  end

  private

  def expertise_params
    params.require(:user).permit(expertise_ids: [])
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.authenticated?(:activation, params[:id])
      redirect_to root_url
    end
  end
end
