require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class MerchantTest < ActiveSupport::TestCase

  test "save" do
    merchant = Factory.build(:merchant)
    assert merchant.save, "merchant is invalid:  #{merchant.errors.full_messages.join('; ')}"
  end
  
  test "associations" do
    merchant = merchants(:tardis_shoppe)
    assert !merchant.items.empty?
  end

  test "name validation" do
    merchant = Factory.build(:merchant)
    assert_validates_blank merchant, 'name'
    assert_validates_length merchant, 'name', 100
  end
  
  test "address validation" do
    merchant = Factory.build(:merchant)
    assert_validates_blank merchant, 'address'
    assert_validates_length merchant, 'address', 250
  end
  
end
