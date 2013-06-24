class Notify < ActiveRecord::Base
  attr_accessible :end_date, :isbn_number
  belongs_to :user
  
end
