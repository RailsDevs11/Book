class User::BookDetailsController < User::BaseController
  before_filter :authenticate_user!
  layout 'dashboard'

  def index
    @book_details = BookDetail.search(params[:search], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @book_details }
    end
  end

  def show
    @book_detail = BookDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book_detail }
    end
  end

  def new
    @book_detail = BookDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book_detail }
    end
  end

  def edit
    @book_detail = BookDetail.find(params[:id])
  end

  def create
    @book_detail = current_user.book_details.build(params[:book_detail])
    respond_to do |format|
      if @book_detail.save
        format.html { redirect_to user_book_detail_path(@book_detail), notice: 'Book detail was successfully created.' }
        format.json { render json: @book_detail, status: :created, location: @book_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @book_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def buy_book
    @book_detail = BookDetail.find(params[:book_id])
    BookDetailMailer.notification_email(current_user).deliver
    BookDetailMailer.inform_email(@book_detail).deliver
    redirect_to @book_detail
  end

  def update
    @book_detail = BookDetail.find(params[:id])

    respond_to do |format|
      if @book_detail.update_attributes(params[:book_detail])
        format.html { redirect_to user_book_detail_path, notice: 'Book detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book_detail = BookDetail.find(params[:id])
    @book_detail.destroy

    respond_to do |format|
      format.html { redirect_to user_book_details_path, notice: 'Book detail was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
