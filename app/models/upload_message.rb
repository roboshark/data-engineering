class UploadMessage < ActiveRecord::Base
  
  validates :upload, :presence => true
  validates :message, :presence => true, :length => { :maximum => 250 }
  validates :row_number, :presence => true, :numericality => { :only_integer => true }

  belongs_to :upload

end
