class UsersController < ApplicationController
  # Catch user record not found exception -- ASSERT THIS WORKS AS INTENDED
  rescue_from ActiveRecord::RecordNotFound, :with => :user_not_found

  def user_not_found
    flash[:danger] = "User not found"
    redirect_to users_url
  end

  before_action :logged_in_user, only: [:index, :show, :staff, :students, :new, :create, :edit, :update, :update_gravatar, :destroy]
  before_action :correct_user,   only: [:edit, :update, :update_gravatar]
  before_action :admin_user,     only: :destroy

  def index
    if(params.has_key?(:search) && params[:search].strip != "")
      @users = User.where(activated: true, school_id: current_user.school_id).order('name ASC').where("name like ?", "%#{params[:search]}%").paginate(page: params[:page], :per_page => 20)
      @page_title = "Search results for \"#{params[:search]}\""
      @browser_title = "Results for \"#{params[:search]}\""
    else
      @users = User.where(activated: true, school_id: current_user.school_id).order('name ASC').paginate(page: params[:page], :per_page => 20)
      @page_title = "All Users at #{school_name}"
      @browser_title = "Users"
    end
  end

  def students
    @users = User.where(activated: true, school_id: current_user.school_id, admin: false).order('name ASC').paginate(page: params[:page], :per_page => 20)
  end

  def staff
    @users = User.where(activated: true, school_id: current_user.school_id, admin: true).order('name ASC').paginate(page: params[:page], :per_page => 20)
  end

  def show
    @user = User.find(params[:id])
    if !@user.activated
      flash[:warning] = "Account not activated."
      redirect_to users_url
    elsif @user.school_id != current_user.school_id
      flash[:danger] = "User not found"
      redirect_to users_url
    end
  end

  def new
    if logged_in? && !current_user.admin
      redirect_to "#{root_url}u/#{current_user.id}"
    else
      @user = User.new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  # Creates new user, correctly referring school
  def create

    @school = School.find(current_user.school_id == 1 && params[:user].has_key?(:school) ? params[:user][:school] : current_user.school_id)
    @user = @school.users.build(user_params)
    @user.color = rand(1...6)
    if @user.save
      @user.send_activation_email
      flash[:info] = "#{@user.name.split[0]} has been sent an email with instructions to activate their account."
      redirect_to current_user.school_id == 1 && params[:user].has_key?(:school) ? "#{adduser_url}?sid=#{params[:user][:school]}" : adduser_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      if @user.gravatar_changed
        flash[:info] = @user.gravatar ? "Added Gravatar - make sure to use the same email address as you use to login to ePerlego." : "Avatar removed."
        redirect_to edit_user_url
      else
        flash[:success] = "Profile updated!"
        redirect_to "#{root_url}u/#{@user.id}"
      end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def to_boolean(str)
    str == 'true'
  end

  private

    # Method uses strong params to prevent illicit assignment of other vars in the database (ie. a user assigning themselves admin)
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :color, :gravatar, :gravatar_changed)
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

    # Confirms admin user of current school
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user.admin? && (current_user.school_id == @user.school_id || current_user.school_id == 1)
    end
end
