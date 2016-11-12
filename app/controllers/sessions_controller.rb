class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to "#{root_url}u/#{current_user.id}"
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or "#{root_url}u/#{user.id}"
      else
        flash[:warning] = "Account not activated. Please check your email for the activation link."
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end
