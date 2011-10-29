require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class PurchaseTest < ActiveSupport::TestCase

  test "save" do
    purchase = Factory.build(:purchase)
    assert purchase.save, "purchase is invalid:  #{purchase.errors.full_messages.join('; ')}"
  end
  
  test "associations" do
    purchase = purchases(:doctor_chameleon_circuit)
    assert_equal purchasers(:doctor), purchase.purchaser
    assert_equal items(:chameleon_circuit), purchase.item
  end

  test "purchaser validation" do
    purchase = Factory.build(:purchase)
    assert_validates_nil purchase, 'purchaser'
  end
  
  test "item validation" do
    purchase = Factory.build(:purchase)
    assert_validates_nil purchase, 'item'
  end
  
  test "upload validation" do
    purchase = Factory.build(:purchase)
    assert_validates_nil purchase, 'upload'
  end

  test "count validation" do
    purchase = Factory.build(:purchase)
    assert_validates_blank purchase, 'count'
    assert_validates_integer purchase, 'count'
  end
  
end
