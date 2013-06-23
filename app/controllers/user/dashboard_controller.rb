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
      @book_details = BookDetail.all
    end
  end
  
end
