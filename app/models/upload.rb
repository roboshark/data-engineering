class Upload < ActiveRecord::Base
  
  validates :file_uid, :presence => true, :length => { :maximum => 200 }
  validates :file_name, :presence => true, :length => { :maximum => 100 }

end
