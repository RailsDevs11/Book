class BookDetailMailer < ActionMailer::Base
  default from: "from@example.com"

  def notification_email(user)
    @user = user
    mail(:to => user.email, :subject => "Notification Email")
  end

  def inform_email(book_obj)
    @user = book_obj.user
    mail(:to => @user.email, :subject => "Inform Email") if !@user.blank?
  end

end
