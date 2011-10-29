require File.expand_path(File.join('..', 'test_helper'), File.dirname(__FILE__))

class UploadMessageTest < ActiveSupport::TestCase

  test "save" do
    upload_message = Factory.build(:upload_message)
    assert upload_message.save, "upload_message is invalid:  #{upload_message.errors.full_messages.join('; ')}"
  end
  
  test "associations" do
    upload_message = Factory.create(:upload_message)
    assert !upload_message.upload.nil?
  end

  test "message validation" do
    upload_message = Factory.build(:upload_message)
    assert_validates_blank upload_message, 'message'
    assert_validates_length upload_message, 'message', 250
  end
  
  test "row_number validation" do
    upload_message = Factory.build(:upload_message)
    assert_validates_blank upload_message, 'row_number'
    assert_validates_integer upload_message, 'row_number'
  end
  
end
