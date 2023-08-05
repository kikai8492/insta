class ConfirmationMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    mail to: @user.email, subject: '投稿確認メール'
  end
end
