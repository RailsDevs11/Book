class User::BookDetailsController < User::BaseController
  before_filter :authenticate_user!
  #layout 'dashboard'

  def index
    @book_details = current_user.book_details.search(params[:search], params[:page])
  end

  def show
    @book_detail = current_user.book_details.find(params[:id])
  end
  
  def search
    isbn_number = params[:ssearch]
    @book = GoogleBooks.search(isbn_number).first
    
    if @book.present?
      @book_detail = current_user.book_details.new(
        :isbn_number => @book.isbn, 
        :author => @book.authors, 
        :title => @book.title,
        :description => @book.description ,
        :image_link => @book.image_link
      )
      flash[:notice] = 'Book detail was successfully fill up, please click on submit.'
    else
      @book_detail = current_user.book_details.new
      flash[:notice] = 'Book detail not found. Could you search again or create manually'
    end
    render :action => :new
  end 
  
  def new
    @book_detail = current_user.book_details.new
  end

  def edit
    @book_detail = current_user.book_details.find(params[:id])
  end

  def create
    @book_detail = current_user.book_details.build(params[:book_detail])
    respond_to do |format|
      if @book_detail.save
        format.html { 
          redirect_to user_book_detail_path(@book_detail), 
          notice: 'Book detail was successfully created.' 
        }
      else
        format.html { 
          render action: "new" 
        }
      end
    end
  end

  def update
    @book_detail = current_user.book_details.find(params[:id])

    respond_to do |format|
      if @book_detail.update_attributes(params[:book_detail])
        format.html { 
          redirect_to user_book_detail_path, 
          notice: 'Book detail was successfully updated.' 
        }
      else
        format.html { 
          render action: "edit" 
        }
      end
    end
  end

  def destroy
    @book_detail = current_user.book_details.find(params[:id])
    @book_detail.destroy

    respond_to do |format|
      format.html { 
        redirect_to user_book_details_path, 
        notice: 'Book detail was successfully deleted.' 
      }
    end
  end
end
