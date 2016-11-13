class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login user
      flash[:success] = "Account activated!"
      flash[:warning] = "Please change your password, or select 'forgot password' next time you log in."
      redirect_to edit_user_url(user)
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
