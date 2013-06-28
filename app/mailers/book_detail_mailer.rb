class BookDetailMailer < ActionMailer::Base
  default from: "from@example.com"

  def notification_email(user)
    @user = user
    mail({
      :to => @user.email,
      :subject => "Notification Email"
    }).deliver
  end

  def inform_email(book_obj)
    @user = book_obj.user
    mail({
      :to => @user.email,
      :subject => "Inform Email"
    }).deliver    
  end

  def user_notify_email(user)
    @user = user
    mail({
      :to => @user.email,
      :subject => "Notify Email"
    }).deliver    
  end

  def notify_to_book_owner(book_detail)
    @user = book_detail.user
    mail({
      :to => @user.email,
      :subject => "Notify to book owner"
    }).deliver    
  end

end
