class Merchant < ActiveRecord::Base
  
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :address, :presence => true, :length => { :maximum => 250 }

  has_many :items

  # Find an existing Merchant by a case in-sensitive search on name, or creates a
  # new one.
  def self.find_or_create(attrs={})
    attrs = attrs.symbolize_keys
    existing = Merchant.where('lower(name) = ?', attrs[:name].downcase).first unless attrs[:name].blank?
    existing || Merchant.create(attrs)
  end

end
