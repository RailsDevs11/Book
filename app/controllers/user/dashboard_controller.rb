class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  
  def index
    @recent_books = current_user.recent_books
  end
  
end
