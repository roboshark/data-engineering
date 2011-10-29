class Item < ActiveRecord::Base
  
  validates :merchant, :presence => true
  validates :description, :presence => true, :length => { :maximum => 200 }
  validates :price, :presence => true, :numericality => { :only_integer => true }

  belongs_to :merchant
  has_many :purchases

end
