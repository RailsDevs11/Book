class BookDetailMailer < ActionMailer::Base
  default from: "from@example.com"

  def notification_email(user)
    @user = user
    mail({
      :to => @user.email,
      :subject => "Notification Email"
    }).deliver
  end

  def purchased_book(book_obj)
    @user = book_obj.user
    @book = book_obj
    mail({
      :to => @user.email,
      :subject => "LccHub: purchased book"
    }).deliver    
  end

  def notify_to_purchase_book(user)
    @user = user
    mail({
      :to => @user.email,
      :subject => "Book is available"
    }).deliver    
  end

  def notify_to_book_owner(book_detail)
    @user = book_detail.user
    mail({
      :to => @user.email,
      :subject => "Need to buy book"
    }).deliver    
  end

end
