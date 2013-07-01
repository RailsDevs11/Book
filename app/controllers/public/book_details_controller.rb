class Public::BookDetailsController < Public::BaseController
  before_filter :authenticate_user!, :only => [:buy_book]
  layout 'simpliq_application', :only => [:show]

  def index
    if params[:search_keyword].present?
      @book_details = BookDetail.book_search_by_keyword(params[:search_keyword])
    end
    
    if @book_details.present?
      @book_details
      flash[:notice] = "Below records found in search result, please click on into title and buy now"
    else
      @book_details = BookDetail.all
    end
  end

  def show
    @book_detail = BookDetail.where(:id => params[:id]).first
  end

  def buy_book
    @book_detail = BookDetail.where(:id => params[:id]).first
    
    if current_user.present? && @book_detail.present?
      @book_detail.update_attributes(:status => true)
      flash[:notice] = "Book was successfully buy"
      BookDetailMailer.notification_email(current_user)
      BookDetailMailer.inform_email(@book_detail)
    else
      flash[:notice] = "Please signin or signup before continue"
    end
    redirect_to(:back)
  end

end
