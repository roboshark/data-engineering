class Item < ActiveRecord::Base
  
  validates :merchant, :presence => true
  validates :description, :presence => true, :length => { :maximum => 200 }
  validates :price, :presence => true, :numericality => { :only_integer => true }

  belongs_to :merchant
  has_many :purchases

  # Find an existing Item by a case in-sensitive search on description, merchant_id and price, or creates a
  # new one.
  def self.find_or_create(attrs={})
    
    attrs = attrs.symbolize_keys

    existing = Item.where('lower(description) = ? and merchant_id = ? and price = ?',
                          attrs[:description].downcase,
                          (attrs[:merchant_id] || attrs[:merchant].id),
                         attrs[:price]).first unless attrs[:description].nil?

    existing || Item.create(attrs)
  
  end

end
