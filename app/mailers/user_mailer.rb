class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation - ePerlego"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Reset Password - ePerlego"
  end
end
