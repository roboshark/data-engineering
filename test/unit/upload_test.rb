require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class UploadTest < ActiveSupport::TestCase

  test "process" do

    # First save the file in the database.
    upload = Upload.new
    upload.file = File.new(File.join(Rails.root, 'example_input.tab'))
    upload.save!

    old_purchaser_count = Purchaser.count
    old_merchant_count = Merchant.count
    old_item_count = Item.count

    # Then process it
    upload.process

    # Timestamp were added
    assert !upload.start_time.nil?
    assert !upload.end_time.nil?

    # Expect 2 new purchasers, 3 merchants, 3 items
    assert_equal old_purchaser_count+2, Purchaser.count, "Wrong number of purchasers"
    assert_equal old_merchant_count+3, Merchant.count, "Wrong number of merchants"
    assert_equal old_item_count+3, Item.count, "Wrong number of items"

    # Check out Snake
    snake = Purchaser.where('name like ?', 'Snake Plissken').first
    assert !snake.nil?, "No Snake"
    assert_equal 2, snake.purchases.count, "Wrong number of Snake purchases"

    purchase = snake.purchases.first
    assert_equal "$10 off $20 of food", purchase.item.description
    assert_equal 1000, purchase.item.price
    assert_equal 2, purchase.count
    assert_equal "Bob's Pizza", purchase.item.merchant.name
    assert_equal '987 Fake St', purchase.item.merchant.address

    purchase = snake.purchases.last
    assert_equal "$20 Sneakers for $5", purchase.item.description
    assert_equal 500, purchase.item.price
    assert_equal 4, purchase.count
    assert_equal "Sneaker Store Emporium", purchase.item.merchant.name
    assert_equal '123 Fake St', purchase.item.merchant.address

  end

  test "bad file" do
    upload = Upload.new
    upload.file = File.new(File.join(Rails.root, 'test', 'files', 'bad_input.tab'))
    upload.save!
    upload.process
    assert !upload.upload_messages.empty?
  end

  test "gross revenue" do

    upload = uploads(:upload)
    assert_equal 9000, upload.gross_revenue

    upload2 = Upload.new
    upload2.file = File.new(File.join(Rails.root, 'example_input.tab'))
    upload2.save!
    upload2.process
    assert_equal 9500, upload2.gross_revenue
  end

  test "test next" do

    assert Upload.next.nil?, "Next did not return nil the first time"

    bad = Upload.new
    bad.file = File.new(File.join(Rails.root, 'test', 'files', 'bad_input.tab'))
    bad.save!

    good = Upload.new
    good.file = File.new(File.join(Rails.root, 'example_input.tab'))
    good.save!

    assert_equal bad, Upload.next, "Next did not return the bad upload."
    bad.process

    assert_equal good, Upload.next, "Next did not return the good upload."
    good.process

    assert Upload.next.nil?, "Next did not return nil the last time."

  end

  test "file_uid validation" do
    upload = Factory.build(:upload)
    assert_validates_length upload, 'file_uid', 200
  end
  
  test "file_name validation" do
    upload = Factory.build(:upload)
    assert_validates_length upload, 'file_name', 100
  end
  
end
