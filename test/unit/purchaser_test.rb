require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class PurchaserTest < ActiveSupport::TestCase

  test "save" do
    purchaser = Factory.build(:purchaser)
    assert purchaser.save, "purchaser is invalid:  #{purchaser.errors.full_messages.join('; ')}"
  end
  
  test "associations" do
    purchaser = purchasers(:doctor)
    assert !purchaser.purchases.empty?
  end

  test "name validation" do
    purchaser = Factory.build(:purchaser)
    assert_validates_blank purchaser, 'name'
    assert_validates_length purchaser, 'name', 100
  end
  
end
