class Purchaser < ActiveRecord::Base
  
  validates :name, :presence => true, :length => { :maximum => 100 }

  has_many :purchases, :order => 'purchases.created_at'

  # Find an existing Purchaser by a case in-sensitive search on name, or creates a
  # new one.
  def self.find_or_create(attrs={})
    attrs = attrs.symbolize_keys
    existing = Purchaser.where('lower(name) = ?', attrs[:name].downcase).first unless attrs[:name].blank?
    existing || Purchaser.create(attrs)
  end

end
