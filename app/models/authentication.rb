class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :uid, :provider, :token
  belongs_to :user 
  
  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end
  
end
