require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class PurchaserTest < ActiveSupport::TestCase

  test "find_or_create" do

    amy = purchasers(:amy)

    [ amy.name, amy.name.upcase, amy.name.downcase ].each do |name|
      purchaser = Purchaser.find_or_create(:name => name)
      assert_equal amy, purchaser
    end

    purchaser = Purchaser.find_or_create(:name => 'Sarah Jane Smith')
    assert_equal "Sarah Jane Smith", purchaser.name
    assert purchaser.valid?

  end

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
