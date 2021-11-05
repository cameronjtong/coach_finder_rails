class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: %i[destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Check your email to activate your account'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      flash[:success] = 'User successfully updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @micropost = Micropost.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def search
    if params[:search].blank?
      redirect_to root_url
    else
      @parameter = params[:search].downcase
      @results = User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, expertise_ids:[])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user_is?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
