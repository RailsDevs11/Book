class Public::BookDetailsController < Public::BaseController
  before_filter :authenticate_user!, :only => [:buy_book]

  def index
    @book_details = BookDetail.search(params[:search], params[:page])
  end

  def show
    @book_detail = BookDetail.find(params[:id])
  end

  def new
    @book_detail = BookDetail.new
  end

  def buy_book
    @book_detail = BookDetail.where(:id => params[:id]).first
    
    if current_user.present? && @book_detail.present?
      flash[:notice] = "Book was successfully buy"
      BookDetailMailer.notification_email(current_user).deliver
      BookDetailMailer.inform_email(@book_detail).deliver
    else
      flash[:notice] = "Please signin or signup before continue"
    end
    redirect_to(:back)
  end

end
