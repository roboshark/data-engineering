class Purchaser < ActiveRecord::Base
  
  validates :name, :presence => true, :length => { :maximum => 100 }

  has_many :purchases

end
