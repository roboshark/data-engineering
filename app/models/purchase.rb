class Purchase < ActiveRecord::Base
  
  validates :purchaser, :presence => true
  validates :item, :presence => true
  validates :upload, :presence => true
  validates :count, :presence => true, :numericality => { :allow_nil => true, :only_integer => true }

  belongs_to :purchaser
  belongs_to :item
  belongs_to :upload

end
