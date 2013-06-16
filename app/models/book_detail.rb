class BookDetail < ActiveRecord::Base
  attr_accessible :author, :description, :isbn_number, :price, :title, :user_id, 
    :avatar, :avatar_cache, :image_link, :status
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  #Define validation for every attribute
  validates :title, :presence => true
  validates :price, :presence => true
  validates :isbn_number, :presence => true
  validates :author, :presence => true

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
           :order => 'title'
  end

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

end
