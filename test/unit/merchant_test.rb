require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class MerchantTest < ActiveSupport::TestCase

  test "find_or_create" do

    tardis_shoppe = merchants(:tardis_shoppe)

    [ tardis_shoppe.name, tardis_shoppe.name.upcase, tardis_shoppe.name.downcase ].each do |name|
      merchant = Merchant.find_or_create(:name => name, :address => 'A test address.')
      assert_equal tardis_shoppe, merchant
    end

    merchant = Merchant.find_or_create(:name => Factory.next(:name), :address => 'A test address.')
    assert merchant.valid?

  end

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
