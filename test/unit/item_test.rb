require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class ItemTest < ActiveSupport::TestCase

  test "save" do
    item = Factory.build(:item)
    assert item.save, "item is invalid:  #{item.errors.full_messages.join('; ')}"
  end
  
  test "associations" do
    item = items(:chameleon_circuit)
    assert !item.merchant.nil?
    assert !item.purchases.empty?
  end

  test "description validation" do
    item = Factory.build(:item)
    assert_validates_blank item, 'description'
    assert_validates_length item, 'description', 200
  end
  
  test "price validation" do
    item = Factory.build(:item)
    assert_validates_blank item, 'price'
    assert_validates_integer item, 'price'
  end
  
  test "merchant validation" do
    item = Factory.build(:item)
    assert_validates_nil item, 'merchant'
  end

end
