class UsersController < ApplicationController
  # Catch user record not found exception -- ASSERT THIS WORKS AS INTENDED
  rescue_from ActiveRecord::RecordNotFound, :with => :user_not_found

  def user_not_found
    flash[:danger] = "User not found"
    redirect_to users_url
  end

  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    if !@user.activated
      flash[:warning] = "Account not activated."
      redirect_to users_url
    end
  end

  def new
    if logged_in?
      redirect_to "#{root_url}u/#{current_user.id}"
    else
      @user = User.new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
#      login @user
#      flash[:success] = "Welcome to ePerlego!"
#      redirect_to "#{root_url}u/#{@user.id}"
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to "#{root_url}u/#{@user.id}"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    # Method uses strong params to prevent illicit assignment of other vars in the database (ie. a user assigning themselves admin)
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please login"
        redirect_to login_url
      end
    end

    # Confirms current user is expected user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
