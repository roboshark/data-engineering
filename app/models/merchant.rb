class Merchant < ActiveRecord::Base
  
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :address, :presence => true, :length => { :maximum => 250 }

  has_many :items

end
