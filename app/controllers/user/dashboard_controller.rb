class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  
  def index
    if params[:search_keyword].present?
      @book_details = BookDetail.book_search_by_keyword(params[:search_keyword])
    end
    
    if @book_details.present?
      @book_details
      flash[:notice] = "Below records found in search result, please click on into title and buy now"
    else
      @book_details = BookDetail.where('status = ?', false)
    end
  end

  def cart
    if params[:search_keyword].present?
      @book_details = BookDetail.book_search_by_keyword(params[:search_keyword])
    end
    
    if @book_details.present?
      @book_details
      flash[:notice] = "Below records found in search result, please click on into title and buy now"
    else
      @book_details = BookDetail.where('status = ?', true)
    end
  end

  def cart_destroy
    @book_detail = BookDetail.find(params[:id])
    if @book_detail.update_attributes(:status => false)
      redirect_to cart_user_dashboard_index_path, notice: 'Book detail was successfully updated.' 
    else
      render action: "cart" 
    end
  end

  def send_message
    book_detail = BookDetail.where(:id => params[:id]).first
    if !(book_detail.blank? || book_detail.user.blank?)
      book_detail.update_attributes(:msg_count => (book_detail.msg_count + 1))
      BookDetailMailer.notify_to_book_owner(book_detail)
      flash[:notice] = "Send message successfully to book owner"
    else
      flash[:notice] = "Book user not found"   
    end
    redirect_to(:back)  
  end  
  
end
