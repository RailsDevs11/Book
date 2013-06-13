class BookDetail < ActiveRecord::Base
  attr_accessible :author, :description, :isbn_number, :price, :title, :user_id, 
    :avatar, :avatar_cache
  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  #Define validation for every attribute
  validates :title, :presence => true
  validates :price, :presence => true
  validates :isbn_number, :presence => true
  validates :description, :presence => true
  validates :author, :presence => true

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
           :order => 'title'
  end

end
