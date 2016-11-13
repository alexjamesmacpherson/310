class SchoolsController < ApplicationController
  before_action :super_user, only: [:index, :new, :create]
  before_action :school_admin, only: [:show]

  def index
    @schools = School.where.not(id: current_user.school_id).paginate(page: params[:page])
  end

  def show
  end

  def new
  end

  def create
  end

  private

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
