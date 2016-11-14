class SchoolsController < ApplicationController
  before_action :super_user, only: [:index, :new, :create]
  before_action :school_admin, only: [:show, :edit, :update]

  def index
    if(params.has_key?(:search) && params[:search].strip != "")
      @schools = School.where.not(id: current_user.school_id).where("name like ?", "%#{params[:search]}%").paginate(page: params[:page], :per_page => 20)
      @page_title = "Search results for \"#{params[:search]}\""
      @browser_title = "Results for \"#{params[:search]}\""
    else
      @schools = School.where.not(id: current_user.school_id).order('name ASC').paginate(page: params[:page], :per_page => 20)
      @page_title = "All Schools"
      @browser_title = "Schools"
    end
  end

  def show
    @school = School.find(params[:id])
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      flash[:info] = "#{school.name.split[0]} has been sent an email with instructions to activate their account."
      redirect_to adduser_url
#      login @user
#      flash[:success] = "Welcome to ePerlego!"
#      redirect_to "#{root_url}u/#{@user.id}"
    else
      render 'new'
    end
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update_attributes(school_params)
      if @school.users_changed
        User.where(school_id: @school.id, activated: false).destroy_all
        flash[:success] = "Deleted all unactivated users."
        redirect_to edit_school_url
      else
        flash[:success] = "School updated!"
        redirect_to @school
      end
    else
      render 'edit'
    end
  end

  private

    # Method uses strong params to prevent illicit assignment of other vars in the database (ie. a user assigning themselves admin)
    def school_params
      params.require(:school).permit(:name, :email, :gravatar, :motto, :users_changed)
    end

    def super_user
      if !logged_in? || current_user.school_id != 1
        redirect_to root_url
      end
    end

    def school_admin
      @school = School.find(params[:id])
      unless logged_in? &&
             @school.id != 1 &&
             current_user.admin &&
             (current_user.school_id == @school.id || current_user.school_id == 1)
        redirect_to schools_url
      end
    end
end
