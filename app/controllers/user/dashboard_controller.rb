class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  
  def index
    if params[:search_keyword].present?
      @book_details = BookDetail.book_search_by_keyword(params[:search_keyword])
    end
    
    if @book_details.present?
      @book_details
      flash[:notice] = "Below records found in search result"
    else
      @book_details = BookDetail.all
      #flash[:notice] = "No records found in search result, so listing all the book"
    end
    #redirect_to user_dashboard_index_path
  end
  
end
