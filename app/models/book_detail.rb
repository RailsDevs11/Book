class BookDetail < ActiveRecord::Base
  attr_accessible :author, :description, :isbn_number, :price, :title, :user_id, 
    :avatar, :avatar_cache, :image_link, :status, :edition, :condition, :msg_count
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  #Define validation for every attribute
  validates :title, :presence => true
  validates :price, :presence => true
  validates :isbn_number, :presence => true
  validates :author, :presence => true

  #callback
  after_create :notifiy_to_user

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
           :order => 'title'
  end

  CONDITION = {'New' => 1, 'Good' => 2, 'Very Good' => 3, 'Acceptable' => 4}

  #use scope to search book result from db
  scope :book_search_by_keyword, lambda {|keyword|
    self.where(
      "lower(author) like ? "+
      "or "+
      "lower(isbn_number) like ? "+
      "or "+
      "lower(title) like ? ",
      '%'+ keyword.downcase+'%',
      '%'+keyword.downcase+'%',
      '%'+keyword.downcase+'%'
    )
  }

  def notifiy_to_user
    notifies = Notify.where("lower(isbn_number) = ? AND end_date >= ?", self.isbn_number, self.created_at)
    if !notifies.blank?
      notifies.each do |notify|
        BookDetailMailer.notify_to_purchase_book(notify.user)
      end  
    end  
  end
end
